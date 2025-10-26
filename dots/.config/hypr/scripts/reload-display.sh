#!/bin/bash

# Reload wallpaper (adjust based on your wallpaper tool)
# For hyprpaper:
killall hyprpaper && hyprpaper &

# For swww:
# swww init && swww img /path/to/your/wallpaper.jpg

# Reload waybar
killall waybar && waybar &
