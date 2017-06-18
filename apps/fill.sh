#!/bin/bash

rhash() {
    if [ `uname` == "Darwin" ]; then echo $RANDOM | md5
    else echo $RANDOM | md5sum | awk '{print $1}'; fi
}

for ((i = 1;; i++)); do
    echo "Getting photo $i..."
    curl -s "https://www.fillmurray.com/$((100+$RANDOM%2000))/$((100+$RANDOM%2000))" --output "$(rhash).jpg"
done
