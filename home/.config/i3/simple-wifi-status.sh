[ $BLOCK_BUTTON = 1 ] && wicd-client --no-tray &> /dev/null
ssid=$(/sbin/iwgetid -r)
if [ $ssid = ""]
then
  echo WifiDown
  echo
  echo \#FF0000
else
  echo $ssid
  echo
  echo \#00FF00
fi
