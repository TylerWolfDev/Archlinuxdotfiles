#!/bin/bash

# url: https://github.com/iye/lightsOn


L_C_S__=() # templet Lock Close Suspend

LCS_(){
    if [ $1 != "n" ]
        sleep $1
        ~/.Scripts/DSlocker.sh
    fi 
    if [ $2 != "n" ]
        sleep $2 
        xset dpms force off
    fi
    if [ $3 != "n" ]
        sleep $3
        systemctl suspend
    fi
}

