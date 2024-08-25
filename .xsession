#!/bin/sh

xsetroot -solid black &

# Normal keyboard.
setxkbmap -option "ctrl:nocaps" -option "compose:rctrl"

# Atreus
#setxkbmap us -option "compose:sclk"

xscreensaver -no-splash &
xscreensaver-systemd &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
(pkill -x automount.bash >/dev/null; ~/.local/bin/automount.bash) &
dunst &

if [ -e /usr/bin/mpd && ! -f $HOME/.mpd/down ]; then
    pgrep -x mpdscribble >/dev/null || mpdscribble &
    pgrep -x mpd >/dev/null || mpd &
fi

export OOO_FORCE_DESKTOP=gnome
export _JAVA_AWT_WM_NONREPARENTING=1

feh -q -z -r --bg-max --no-fehbg ~/Pictures/wallpapers/simpledesktops

# Disabling blanking screen (odd behaviour)
xset s off
xset -dpms

exec ssh-agent /usr/bin/i3
