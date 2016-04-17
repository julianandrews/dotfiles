#!/usr/bin/env sh

ethernet_up=$(cat /sys/class/net/eth0/operstate | grep 'up')
ssid=$(/sbin/iwgetid -r)
color=\#268bd2
wifi_text="<fc=#6c71c4><fn=1></fn></fc> $ssid"
ethernet_text="<fn=1></fn>"
netdown_text="<fc=#dc322f><fn=1></fn></fc>"

if [ "$ethernet_up" ]
then
  [ "$ssid" ] && full_text="$ethernet_text / $wifi_text" || full_text="$ethernet_text"
else
  [ ! "$ssid" ] && full_text="$netdown_text" || full_text="$wifi_text"
fi

echo "<action=\`wicd-client --no-tray &> /dev/null\`><fc=$color>$full_text</fc></action>"
