#!/usr/bin/env sh

ethernet_up=$(cat /sys/class/net/eth0/operstate | grep 'up')
ssid=$(/sbin/iwgetid -r)
color=\#268bd2

if [ "$ethernet_up" ]
then
  [ "$ssid" ] && full_text="Ethernet/$ssid" || full_text='Ethernet'
else
  [ ! "$ssid" ] && full_text='NetDown' && color=\#dc322f || full_text="$ssid"
fi

echo "<action=\`wicd-client --no-tray &> /dev/null\`><fc=$color>$full_text</fc></action>"
