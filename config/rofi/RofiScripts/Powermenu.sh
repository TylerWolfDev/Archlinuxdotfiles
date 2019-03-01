#!/bin/bash

# small power menu using rofi, i3, systemd and pm-utils
# (last 3 dependencies are adjustable below)
# tostiheld, 2016

Poweroff="systemctl poweroff"
Reboot="systemctl reboot"
Lock="i3lock"
Exit="exit"
Suspend="systemctl suspend" 

# you can customise the rofi command all you want ...
rofi_command="rofi -width 10 -hide-scrollbar -show-icons -config $HOME/.dotfiles/config/rofi/themes/Powermenu.rasi "

options=$'Lock\nSuspend\nPoweroff\nReboot\nExit'

# ... because the essential options (-dmenu and -p) are added here
eval \$"$(echo "$options" | $rofi_command -dmenu -p "")"