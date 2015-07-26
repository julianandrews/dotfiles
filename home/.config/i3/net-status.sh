#!/bin/sh

[ "$BLOCK_BUTTON" = 1 ] && wicd-client --no-tray &> /dev/null

ethernet_up=$(cat /sys/class/net/eth0/operstate | grep 'up')
ssid=$(/sbin/iwgetid -r)
color=\#00FF00

if [ "$ethernet_up" ]
then
  [ "$ssid" ] && full_text="Ethernet/$ssid" || full_text='Ethernet'
else
  [ ! "$ssid" ] && full_text='NetDown' && color=\#FF0000 || full_text="$ssid"
fi

echo "$full_text"
echo "$short_text"
echo "$color"
