#!/bin/bash

pathtoname() {
    udevadm info -p "/sys/$1" | awk -v FS== '/DEVNAME/ {print $2}'
}

while read -r _ _ event devpath _; do
    if [[ $event == add ]]; then
        devname=$(pathtoname "$devpath")
        notify_message=$(udisksctl mount --block-device "$devname" --no-user-interaction)
        notify-send -i 'drive-harddisk' "$notify_message"
    fi
done < <(stdbuf -o L udevadm monitor --udev -s block)
