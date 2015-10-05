#!/bin/sh

image_file=/tmp/screen_lock.png
scrot -z "$image_file"
mogrify -scale 5% -scale 2000% "$image_file"
i3lock -e -i "$image_file"
