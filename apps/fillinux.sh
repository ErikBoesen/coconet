#!/bin/bash

for ((i = 1;; i++)); do
    echo "Getting photo $i..."
    curl -s "https://www.fillmurray.com/$((100+$RANDOM%2000))/$((100+$RANDOM%2000))" --output "$(echo $RANDOM | md5sum).jpg"
done
