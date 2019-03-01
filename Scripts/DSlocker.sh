#!/bin/env bash
#
#  ____  ____  _            _             
# |  _ \/ ___|| | ___   ___| | _____ _ __ 
# | | | \___ \| |/ _ \ / __| |/ / _ \ '__|
# | |_| |___) | | (_) | (__|   <  __/ |   
# |____/|____/|_|\___/ \___|_|\_\___|_|   
#                                         
#

# Orginal: https://github.com/reorr/mantablockscreen

# Dependices"
#   bash
#   i3lock-color
# 	ccal

wallpaper=$2
cachepath=$HOME/Pictures/Wallpapers/LockScreen/
fullname=`getent passwd $USER | cut -d ":" -f 5`
full_alias="${fullname} (${USER})"
#fullname=`cat ~/qq`
if [[ -n $fullname ]]; then
	full_alias="${fullname} (${USER})"
else
	full_alias="${fullname}"
fi

width=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*' | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/' |cut -d "x" -f 1)
height=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*' | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/' |cut -d "x" -f 2)
half_width=$((width/2))
half_height=$((height/2))

fg_color=fefefeff
wrong_color=f82a11aa
highlight_color=39393999
verif_color=fefefe66

slowfade () {
    dis=$(echo -n "$DISPLAY" | tr -c '[:alnum:]' _)
    ifc='com.github.chjj.compton'
    obj='/com/github/chjj/compton'
    if [[ "$1" == "start" ]]; then
        dbus-send --print-reply --dest=$ifc.$dis \
            $obj $ifc.opts_set string:fade_in_step double:0.02
        dbus-send --print-reply --dest=$ifc.$dis \
            $obj $ifc.opts_set string:fade_out_step double:0.02
    else
        dbus-send --print-reply --dest=$ifc.$dis \
            $obj $ifc.opts_set string:fade_in_step double:0.1
        dbus-send --print-reply --dest=$ifc.$dis \
            $obj $ifc.opts_set string:fade_out_step double:0.1
    fi
}

lock() {
#	slowfade start
	i3lock -n --force-clock -i $cachepath/1.jpg \
    --indpos="w/2:h/2+100" --timepos="w/2:h/2-100" --datepos="w/2:h/2-50" --greeterpos="w/2:h/2+20" \
    --insidevercolor=$fg_color --insidewrongcolor=$wrong_color --insidecolor=fefefe00 \
    --ringvercolor=$verif_color --ringwrongcolor=$wrong_color --ringcolor=$fg_color \
    --keyhlcolor=$highlight_color --bshlcolor=$highlight_color --separatorcolor=00000000 \
    --datecolor=$fg_color --timecolor=$fg_color --greetercolor=$fg_color \
    --timestr="%H:%M" --timesize=100 \
    --datestr="%a, %y %b %d" --datesize=30 \
    --greetertext="$full_alias" --greetersize=25\
    --line-uses-ring \
    --radius 38 --ring-width 3 --indicator \
    --veriftext=""  --wrongtext="" --noinputtext="" \
    --clock --date-font="Google Sans" --time-font="Google Sans"
	sleep 1
#	slowfade end
}

stackclock() {
	slowfade start
	date_now=$(date +'%b, %d')
	i3lock -n --force-clock -i $cachepath/1.jpg \
	--indpos="w/2:h/2+60" --timepos="w/2:h/2-100" --datepos="w/2:h/2-30" --greeterpos="w/2:h/2" \
	--insidevercolor=$verif_color --insidewrongcolor=$wrong_color --insidecolor=fefefe00 \
	--ringvercolor=$verif_color --ringwrongcolor=$wrong_color --ringcolor=$fg_color \
	--keyhlcolor=$highlight_color --bshlcolor=$highlight_color --separatorcolor=00000000 \
	--datecolor=$fg_color --timecolor=$fg_color --greetercolor=$fg_color \
	--timestr="%H" --timesize=70 \
	--datestr="%M" --datesize=70 \
	--greetertext="$date_now" --greetersize=25\
	--line-uses-inside --radius 50 --ring-width 2 --indicator \
	--veriftext=""  --wrongtext="" --noinputtext="" \
	--clock --date-font="Google Sans" --time-font="Google Sans"
	sleep 1
	slowfade end
}

circleclock() {
	slowfade start
	i3lock -n --force-clock -i $cachepath/1.jpg \
	--indpos="w/2:h/2" --timepos="w/2:h/2-5" --datepos="w/2:h/2+35" --greeterpos="w/2:h/2" \
	--insidevercolor=5f5f5f66 --insidewrongcolor=$wrong_color --insidecolor=5f5f5f66 \
	--ringvercolor=$verif_color --ringwrongcolor=$wrong_color --ringcolor=$fg_color \
	--keyhlcolor=$highlight_color --bshlcolor=$highlight_color --separatorcolor=00000000 \
	--datecolor=$fg_color --timecolor=$fg_color --greetercolor=$fg_color \
	--timestr="%H | %M" --timesize=40 \
	--datestr="%a, %d %b" --datesize=25 \
	--greetertext="$date_now" --greetersize=25 \
	--line-uses-inside --radius 75 --ring-width 2 --indicator \
	--veriftext=""  --wrongtext="" --noinputtext="" \
	--clock --date-font="Google Sans" --time-font="Google Sans"
	sleep 1
	slowfade end
}

show_help(){
	cat <<-EOF                                 
	Usage :
	 DSlocker.sh [OPTION]
	Avaible options:
	 -i, --image             Generate cache image
	 -sc, --stackclock       Show lockscreen with stacked digital clock
	 -cc, --circleclock      Show lockscreen with clock inside circle
	 -h, --help              Show this help
	EOF
}

case $1 in 
	-h|--help)
		show_help ;;
	-sc|--stackclock)
		stackclock ;;
	-cc|--circleclock)
		circleclock ;;
	*)
#		circleclock ;; 
		lock ;;
esac