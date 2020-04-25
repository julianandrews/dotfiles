#!/bin/sh

bl_device=/sys/class/backlight/intel_backlight
read brightness < ${bl_device}/brightness
read max_brightness < ${bl_device}/max_brightness

if [ "$1" = "video/brightnessup" ]; then
    new_brightness=$(($brightness + $max_brightness / 5))
    [ "$new_brightness" -gt "$max_brightness" ] && new_brightness=$max_brightness
elif [ "$1" = "video/brightnessdown" ]; then
    new_brightness=$(($brightness - $max_brightness / 5))
    [ "$new_brightness" -lt 0 ] && new_brightness=0
fi

echo $new_brightness > "${bl_device}/brightness"
