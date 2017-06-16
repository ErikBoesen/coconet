#!/bin/bash

# Counts how many nodes are up

UP=0
DOWN=0

if [ "$1" = "" ]; then
    FILE="nodes.txt"
else
    FILE=$1
fi

while read node; do
    USER=`echo $node | awk '{print $1}'`
    HOSTNAME=`echo $node | awk '{print $3}'`
    printf "Pinging node $USER@$HOSTNAME... "
    ping -t 1 -c 1 $HOSTNAME > /dev/null
    if [ "$?" = 0 ]; then
        echo -e "up."
        UP=$((UP+1))
    else
        echo -e "down."
        DOWN=$((DOWN+1))
    fi
done <$FILE

echo "$UP/$(($UP+$DOWN)) nodes up."
