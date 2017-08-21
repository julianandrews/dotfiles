#! /bin/sh

handle_open() {
    return
}

handle_close() {
    if [ $(cat /sys/class/power_supply/AC/online) = 0 ]
    then
        echo "suspending" >> /tmp/lidlog
        systemctl suspend
    fi
}

case "$3" in
    open) handle_open ;;
    close) handle_close ;;
esac
