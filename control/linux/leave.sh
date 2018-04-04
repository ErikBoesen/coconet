#!/bin/bash
host=boesen.science
down_port=2042
up_port=2043

echo "Removing pubkey..."
rm /root/.ssh/authorized_keys
echo "Removing crontabs..."

read -p "Disable SSH (not recommended)? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    printf "Stopping SSHD..."
    systemctl stop ssh.service
    echo " done."
    printf "Removing SSHD from startup programs..."
    systemctl disable ssh.service
    echo " done."
fi

grep -v "$host" /var/spool/cron/tabs/root > /tmp/crontab
mv /tmp/crontab /var/spool/cron/tabs

printf "EXIT: $(< /etc/info) leaving network." >/dev/tcp/$host/$up_port
rm -rf /var/log/*
rm -rf /etc/info /etc/ips
