image_file=/tmp/screen_lock.png
scrot "$image_file"
mogrify -scale 5% -scale 2000% "$image_file"
i3lock -i "$image_file"
