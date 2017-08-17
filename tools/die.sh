#!/bin/bash

# TODO: Test this, probably broken

node=`grep "^$1" nodes.txt`
user=`echo $node | awk '{print $1}'`
host=`echo $node | awk '{print $3}'`

ssh $user@$host -t <<EOF
killall Google\ Chrome
osascript -e 'repeat' \
        -e 'tell application "System Events"' \
        -e 'key code 107' \
	-e 'done'
        -e 'end tell' &
shutdown now
EOF
