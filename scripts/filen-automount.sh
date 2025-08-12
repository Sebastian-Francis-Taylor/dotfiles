#!/bin/bash
FILENPATH=/home/taylor/.filen-cli/bin/filen
MOUNTPOINT=$HOME/Cloud

mkdir -p $MOUNTPOINT

$FILENPATH mount $MOUNTPOINT &

# wait for mount to be complete
sleep 5

if ! mountpoint -q $MOUNTPOINT; then
    notify-send -u critical "Filen Mount Failed!" "Cloud storage not mounted"
fi
