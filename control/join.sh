#!/usr/bin/bash
host=boesen.science
down_port=2042
up_port=2043

if [[ "$OSTYPE" == "linux"* ]]; then
    # GNU/Linux
    echo "Detected GNU/Linux system."
    curl -L $host:$down_port/linux/join.sh |bash
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS/OS X
    echo "Detected macOS/OS X system."
    curl -L $host:$down_port/mac/join.sh |bash
else
    echo "Unknown system."
fi
