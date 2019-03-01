#!/bin/bash

# DS 系列
# tsl := termianl soft list.
# 屏幕上方的的终端程序小列表。

#tdropcom=tdrop -w 30% -h 38% -x 700 -y 30 -n 3 -f "-e DStsl.sh" -a termite

power(){
    dialog --title "Power option" --menu "" 12 35 5 \
                                    1 "suspend" \
                                    2 "poweroff" \
                                    3 "reboot"  \
                                    2>/tmp/post.txt
	status=`cat /tmp/post.txt`

    if [ $status == 1 ]
    then
        DSlocker.sh
        systemctl suspend
        sleep 2

    elif [ $status == 2 ]
    then
        systemctl poweroff
        sleep 2

    elif [ $status == 3 ]
    then
        systemctl reboot
        sleep 2
	fi
}




main0() {
    dialog --title "Terminal programs" --menu "" 12 35 5 \
                                    1 "nmtui"  \
                                    2 "alsamixer" \
                                    3 "powermanager"\
                                    4 "EXIT!" \
                                    2>/tmp/m.txt
	p=`cat /tmp/m.txt`

    if [ $p == 1 ]
	then
        nmtui
    elif [ $p == 2 ]
    then
        alsamixer
    elif [ $p == 3 ]
    then
        power
    else 
        exit
	fi


}

main0