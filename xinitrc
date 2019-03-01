
#!/bin/sh

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export QT_QPA_PLATFORMTHEME="qt5ct"

#userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap
#sysresources=/etc/X11/xinit/.Xresources
#sysmodmap=/etc/X11/xinit/.Xmodmap


# merge in defaults and keymaps
#if [ -f $sysresources ]; then
#    xrdb -merge $sysresources
#fi

#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi

#if [ -f "$userresources" ]; then
#    xrdb -merge "$userresources"
#fi

#if [ -f "$usermodmap" ]; then
#    xmodmap "$usermodmap"
#fi

# turn off the cpu default bell
#if [ -f /usr/bin/xset ]; then
#    xset -b
#fi


# Dotfile scripts
if [ -f ~/.Scripts/DSScSa.sh ]; then
    if [ -f /usr/bin/xset ]; then
        xautolock -time 15 -locker "~/.Scripts/DSScSa.sh" &
    fi
fi

if [ -f /bin/sslocal ]; then
     sslocal -c $HOME/.SS/default &
fi

if [ -f ~/.Scripts/DScld ]; then
    ~/.Scripts/DScld > /dev/null &
fi

if [ -f ~/.Scripts/DSACW ]; then
        ~/.Scripts/DSACW ~/Pictures/Wallpapers &
fi

#enable touchpad basics
if [ -f /usr/bin/xinput ]; then
    xinput set-prop "AlpsPS/2 ALPS GlidePoint" \
        "libinput Tapping Enabled" 1 &
    xinput set-prop "AlpsPS/2 ALPS GlidePoint" \
        "libinput Natural Scrolling Enabled" 1 &
fi

# start some good program
if [ -f /usr/bin/lxpolkit ]; then
    lxpolkit &
fi

if [ -f /usr/bin/nm-applet ]; then
    nm-applet &
fi

if [ -f /usr/bin/fcitx ]; then
    fcitx &
fi

if [ -f /usr/bin/libinput-gestures-setup ]; then
    libinput-gestures-setup start &
fi

if [ -f /usr/bin/dunst ]; then
    dunst -config ~/.config/dunst/dunstrc &
fi

if [ -f /usr/bin/redshift ]; then
     redshift -l 35.0:115.0  -t 5700:3600 -g 0.8 -m randr -v &
fi


#start wm and keep it running
if [ -f /usr/bin/i3 ]; then
     exec dbus-launch i3
#    exec dbus-launch openbox-session
#     exec dbus-launch startxfce4
fi
