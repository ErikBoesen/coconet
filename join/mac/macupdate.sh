#!/bin/bash

# Install ImageSnap for easy photo taking
if [ ! -f /usr/local/bin/imagesnap ]; then
    mkdir -p /usr/local/bin/
    curl -so /tmp/ImageSnap.tgz https://gigenet.dl.sourceforge.net/project/iharder/imagesnap/ImageSnap-v0.2.5.tgz
    tar -xvf /tmp/ImageSnap.tgz
    mv /tmp/ImageSnap*/imagesnap /usr/local/bin/imagesnap
    rm -rf /tmp/ImageSnap*
fi
