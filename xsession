#!/bin/sh

xsetroot -solid black &

setxkbmap -option "ctrl:nocaps" -option "compose:rctrl"

#xfce4-power-manager &
xscreensaver -no-splash &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
(pkill -x automount.bash >/dev/null; ~/.local/bin/automount.bash) &
#nm-applet --sm-disable &
dunst &

if [ -e /usr/bin/mpd && ! -f $HOME/.mpd/down ]; then
    pgrep -x mpdscribble >/dev/null || mpdscribble &
    pgrep -x mpd >/dev/null || mpd &
fi

export OOO_FORCE_DESKTOP=gnome
export _JAVA_AWT_WM_NONREPARENTING=1

feh -q -z -r --bg-max --no-fehbg ~/Pictures/wallpapers/simpledesktops

exec /usr/bin/i3
