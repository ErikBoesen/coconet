#!/usr/bin/env bash

tmux new-session -s cchttp 'cd control && python3 -m http.server 2042'
tmux new-session -s cclisten 'cd server && python3 server.py'
