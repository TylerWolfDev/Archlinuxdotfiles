#!/bin/bash
word=`xclip -out`
echo "$word"
mean=`sdcv ${word}`
echo "$mean"
notify-send -u critical -i none "$mean"