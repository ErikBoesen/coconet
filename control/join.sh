#!/usr/bin/bash
host=boesen.science

if [[ "$OSTYPE" == "linux"* ]]; then
    # GNU/Linux
    echo "Detected GNU/Linux system."
    curl -L $host:2042/linux/join.sh |bash
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS/OS X
    echo "Detected macOS/OS X system."
    curl -L $host:2042/mac/join.sh |bash
else
    echo "Unknown system."
fi
