#!/bin/bash

echo "Removing .ssh..."
rm -rf /var/root/.ssh

dscl . change /Groups/com.apple.access_ssh-disabled RecordName com.apple.access_ssh-disabled com.apple.access_ssh >/dev/null

grep -v "boesen.science" /var/at/tabs/root > /tmp/crontab
mv /tmp/crontab /var/at/tabs/root
