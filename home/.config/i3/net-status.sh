[ $BLOCK_BUTTON = 1 ] && wicd-client --no-tray &> /dev/null
ethernet_status=$(cat /sys/class/net/eth0/operstate)
ssid=$(/sbin/iwgetid -r)
color=\#00FF00
if [ $ethernet_status = 'up' ]
then
  if [ "$ssid" = "" ]
  then
    full_text="Ethernet"
  else
    full_text="Ethernet/$ssid"
  fi
else
  if [ $ssid = ""]
  then
    full_text="NetDown"
    color=\#FF0000
  else
    full_text="$ssid"
  fi
fi

echo "$full_text"
echo
echo "$color"
