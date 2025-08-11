#!/bin/bash
FILENPATH=/home/taylor/.filen-cli/bin/filen
MOUNTPOINT=$HOME/Cloud

$FILENPATH mount $MOUNTPOINT

if ! mountpoint -q $MOUNTPOINT; then
    notify-send -u critical "Filen Mount Failed" "Cloud storange not mounted"
fi
