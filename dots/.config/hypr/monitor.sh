#!/bin/bash

if [ "$(hostname)" = "ArchTop" ]; then
    echo "monitor=DP-1,3840x2160,0x0,1.33"
    echo "monitor=HDMI-A-1, disable"
elif [ "$(hostname)" = "ArchPad" ]; then
   echo "monitor = eDP-1, 1920x1200, 0x0, 1.2"
   echo "monitor = DP-8, preferred, auto, 1, mirror, eDP-1"
fi
