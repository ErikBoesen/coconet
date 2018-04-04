#!/usr/bin/env bash

tmux new-session -d -s cchttp -c $PWD/control 'python3 -m http.server 2042'
tmux new-session -d -s cclisten -c $PWD/server 'python3 server.py'
if [ "$1" = "--rsh" ] || [ "$1" = "-r" ]; then
    tmux new-session -d -s ccrsh 'nc -l -p 2044 -vvv'
fi
