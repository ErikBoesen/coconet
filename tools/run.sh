#/bin/bash

echo $1
while read node; do
    echo "Running on $node"
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$($node | awk '{print $2}') -t "export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH;$1"
done <nodes.txt
