#!/bin/bash

# TODO: Test this, probably broken

ssh erik@`grep "^$1" nodes.txt | awk '{print $3}'` -t <<EOF
killall Google\ Chrome
osascript -e 'repeat' \
        -e 'tell application "System Events"' \
        -e 'key code 107' \
	-e 'done'
        -e 'end tell' &
shutdown now
EOF
