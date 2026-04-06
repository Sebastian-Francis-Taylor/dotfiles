#!/bin/bash
# filen-automount.sh - Mount Filen cloud storage via FUSE
#
# Waits for an internet connection and mounts the Filen drive. Retries up to 3
# times at 2 minute intervals before giving up. Designed to run as a systemd
# user service.
#
# Supports notify-send (GNOME/KDE), dunstify (dunst), and kdialog as
# notification backends.
#
# Copyright 2026, Sebastian F. Taylor
# May be used under the terms of the MIT License.

filen=$HOME/.filen-cli/bin/filen
mountpoint=$HOME/Cloud

notify() {
    local urgency="$1" title="$2" body="$3"

    if command -v notify-send &>/dev/null; then        # gnome/kde/most DEs
        notify-send -u "$urgency" "$title" "$body"
    elif command -v dunstify &>/dev/null; then          # arch + dunst
        dunstify -u "$urgency" "$title" "$body"
    elif command -v kdialog &>/dev/null; then            # kde without libnotify
        kdialog --passivepopup "$title: $body" 10
    else
        echo "[$urgency] $title - $body" >&2
    fi
}

mount_drive() {
    if mountpoint -q "$mountpoint"; then
        echo "already mounted"
        return 0
    fi

    echo "not mounted, attempting to mount..."
    $filen mount "$mountpoint"
    sleep 2

    if mountpoint -q "$mountpoint"; then
        echo "mounted successfully"
    else
        notify critical "Filen Mount Failed" "could not mount cloud storage"
        return 1
    fi
}

try_connect() {
    local attempt=${1:-1}

    if wget -q --spider http://sebastian-taylor.com; then
        mount_drive
        return $?
    fi

    echo "attempt $attempt/3: no internet"

    if [ "$attempt" -ge 3 ]; then
        notify critical "No Internet" "cloud storage could not be mounted after 3 attempts"
        return 1
    fi

    echo "retrying in 2 minutes..."
    sleep 120
    try_connect $((attempt + 1))
}

try_connect
