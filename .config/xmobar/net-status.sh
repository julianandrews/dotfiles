#!/usr/bin/env sh

ethernet_up=''
ethernet_unknown=''
for f in /sys/class/net/*
do
    if [ ! -d "$f/wireless" ] && [ "$f" != "/sys/class/net/lo" ]
    then
        $(grep -q 'up' "${f}/operstate") && ethernet_up=1
        $(grep -q 'unknown' "${f}/operstate") && ethernet_unknown=1
    fi
done
ssid=$(/sbin/iwgetid -r)
color=\#268bd2
wifi_text="<fc=#6c71c4><fn=1></fn></fc> $ssid"
netdown_text="<fc=#dc322f><fn=1></fn></fc>"
if [ "$ethernet_unknown" ]
then
  ethernet_text="⁇"
else
  ethernet_text="<fn=1></fn>"
fi

if [ "$ethernet_up" -o "$ethernet_unknown" ]
then
  [ "$ssid" ] && full_text="$ethernet_text / $wifi_text" || full_text="$ethernet_text"
else
  [ ! "$ssid" ] && full_text="$netdown_text" || full_text="$wifi_text"
fi

echo "<fc=$color>$full_text</fc>"
