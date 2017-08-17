#!/usr/bin/bash

if [[ "$OSTYPE" == "linux"* ]]; then
    # GNU/Linux
    echo "Detected GNU/Linux system."
    curl -L boesen.science:2042/linux/join.sh |bash
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS/OS X
    echo "Detected macOS/OS X system."
    curl -L boesen.science:2042/mac/join.sh |bash
else
    echo "Unknown system."
fi
