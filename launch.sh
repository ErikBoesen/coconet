#!/usr/bin/env bash

tmux new-session -s cchttp -c $PWD/control 'python3 -m http.server 2042'
tmux new-session -s cclisten -c $PWD/server 'python3 server.py'
