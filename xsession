#!/bin/sh

xsetroot -solid black &

setxkbmap -option "ctrl:nocaps"

/usr/lib/xfce4/xfconf/xfconfd &
xfsettingsd &
xfce4-power-manager &
xfce4-volumed &
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)
gsettings-data-convert &
xscreensaver -no-splash &
update-notifier &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/notify-osd/notify-osd &
pgrep -x udisks-glue >/dev/null || udisks-glue &
$HOME/.dropbox-dist/dropboxd &
nm-applet --sm-disable &

if [ ! -f $HOME/.mpd/down ]; then
    pgrep -x mpdscribble >/dev/null || mpdscribble &
    pgrep -x mpd >/dev/null || mpd &
fi

export OOO_FORCE_DESKTOP=gnome
export _JAVA_AWT_WM_NONREPARENTING=1

exec /usr/bin/awesome
