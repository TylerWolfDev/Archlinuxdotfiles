#!/bin/bash
#
#  ____  ____  _                   
# |  _ \/ ___|| |_ _ __ __ _ _   _ 
# | | | \___ \| __| '__/ _` | | | |
# | |_| |___) | |_| | | (_| | |_| |
# |____/|____/ \__|_|  \__,_|\__, |
#                            |___/ 
#

# WangChung

# stalonetray and trayer

if ! pgrep -x trayer; then
	echo "stalonetray not running"
	trayer\
        --SetDockType false\
        --align right\
        --distance -33\
        --distancefrom bottom\
        --edge bottom\
        --transparent true\
        --heighttype request\
         --iconspacing 5\
        --widthtype  request &
else
	pkill trayer
fi


