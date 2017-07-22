#!/bin/bash

echo "Removing pubkey..."
rm /root/.ssh/authorized_keys

read -p "Disable SSH (not recommended)? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
	printf "Stopping SSHD..."
	systemctl stop ssh.service
	echo " done."
	printf "Removing SSHD from startup programs..."
	systemctl disable ssh.service
	echo " done."
fi
