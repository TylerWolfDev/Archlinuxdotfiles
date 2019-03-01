#!/bin/bash

    dialog --title "Terminal programs" --menu "" 12 35 5 \
                                    1 "nmtui"  \
                                    2>/tmp/dm.txt
	p=`cat /tmp/dm.txt`

    if [ $p == 1 ]
	then
        startx
	fi
