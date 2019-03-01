#!/bin/bash
~/.Scripts/DSlocker.sh &
sleep 300s
if pgrep i3lock >/dev/null; then
    systemctl suspend
fi
