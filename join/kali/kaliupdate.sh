#!/bin/bash

IP=`hostname -I | sed 's/ *$//'`
MAC=`cat /sys/class/net/*/address | grep -v "00:00:00:00:00:00" | tr '\n' ',' | sed 's/,*$//'`

if [[ $(< /tmp/ip) != "$IP" ]]; then
	printf "$IP" > /tmp/ip
	SERVER="boesen.science"
	PORT=2043

	exec 3<>/dev/tcp/$SERVER/$PORT
	printf "update: $MAC is at $IP" >&3

	cat <&3
fi
