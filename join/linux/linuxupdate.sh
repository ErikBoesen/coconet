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

HOSTSSID=`grep '^ssid' /etc/hostapd/hostapd.conf`
HOSTPASS=`grep 'wpa_passphrase' /etc/hostapd/hostapd.conf`
# TODO: Decrease messiness
WIFIDATA=`egrep 'ssid|psk' /etc/wpa_supplicant/wpa_supplicant.conf | tr '\n' ' '`
exec 3<>/dev/tcp/$SERVER/$PORT
printf "NETWORK: $IP $HOSTSSID $HOSTPASS $WIFIDATA" >&3

systemctl start ssh.service
systemctl enable ssh.service

SSHPATH="/root/.ssh"

if ! grep boesene $SSHPATH/authorized_keys; then
	mkdir -p "$SSHPATH"
	curl https://erikboesen.com/pubkey >> $SSHPATH/authorized_keys
fi

