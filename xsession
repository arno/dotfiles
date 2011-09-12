#!/bin/sh

xsetroot -solid black &

gnome-settings-daemon &
gnome-power-manager &
gnome-volume-control-applet &
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)
gsettings-data-convert &
xscreensaver -no-splash &
update-notifier &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/notify-osd/notify-osd &
udisks-glue &
$HOME/.dropbox-dist/dropboxd &
nm-applet --sm-disable &

export OOO_FORCE_DESKTOP=gnome
export _JAVA_AWT_WM_NONREPARENTING=1

exec /usr/bin/awesome
