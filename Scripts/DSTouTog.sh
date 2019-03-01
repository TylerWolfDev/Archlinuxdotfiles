#!/bin/bash

#Dotscr-TouchpadToggle

device=$(xinput|grep Touchpad|grep id|awk -F '[=]' '{print $2}'|awk -F '\t' '{print $1}')
state=`xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$"`

if [ $state == '1' ];then
  xinput --disable $device
else
  xinput --enable $device
fi
