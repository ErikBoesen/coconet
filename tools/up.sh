#!/bin/bash

# Counts how many nodes are up

up=0
down=0

if [ "$1" = "" ]; then
    file="nodes.txt"
else
    file=$1
fi

while read node; do
    user=$(echo $node | awk '{print $1}')
    host=$(echo $node | awk '{print $2}')
    printf "Pinging node $user@$host... "
    ping -t 1 -c 1 $host > /dev/null
    if [ "$?" = 0 ]; then
        echo "up."
        up=$((up+1))
    else
        echo "down."
        down=$((down+1))
    fi
done <$file

echo "$up/$(($up+$down)) nodes up."
