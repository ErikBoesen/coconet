#!/bin/bash

if [[ "$OSTYPE" == "linux"* ]]; then
    # GNU/Linux
    echo "Detected GNU/Linux system."
    curl -L erikboesen.com/jl.sh |bash
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS/OS X
    echo "Detected macOS/OS X system."
    curl -L erikboesen.com/jm.sh |bash
else
    echo "Unknown system."
fi
