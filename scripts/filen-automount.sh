#!/bin/bash
FILENEXEC=$HOME/.filen-cli/bin/filen
MOUNTPOINT=$HOME/Cloud

mkdir -p $MOUNTPOINT

$FILENEXEC mount $MOUNTPOINT &

sleep 5

if ! mountpoint -q $MOUNTPOINT; then
    notify-send -u critical "Filen Mount Failed!" "Cloud storage not mounted"
fi
