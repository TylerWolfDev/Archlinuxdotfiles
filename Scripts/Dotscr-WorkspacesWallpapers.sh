#bin/bash

#Use wallpapers in order. And the format of wallpapers must be background_${num}.jpg

xprop -spy -root _NET_CURRENT_DESKTOP | while read -r event; do
    num=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true) | .num')
    feh --bg-fill "$HOME/Pictures/Wallpapers/Current/background_${num}.jpg"
done
