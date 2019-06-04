#!/bin/sh

xsetroot -solid black &

setxkbmap -option "ctrl:nocaps" -option "compose:rctrl"

xfce4-power-manager &
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)
gsettings-data-convert &
xscreensaver -no-splash &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
(pkill -x automount.bash >/dev/null; ~/.local/bin/automount.bash) &
[ -x ~/.dropbox-dist/dropboxd ] && ~/.dropbox-dist/dropboxd &
nm-applet --sm-disable &
dunst &

if [ ! -f $HOME/.mpd/down ]; then
    pgrep -x mpdscribble >/dev/null || mpdscribble &
    pgrep -x mpd >/dev/null || mpd &
fi

export OOO_FORCE_DESKTOP=gnome
export _JAVA_AWT_WM_NONREPARENTING=1

feh -q -z -r --bg-max --no-fehbg ~/Pictures/wallpapers/simpledesktops

exec /usr/bin/i3
