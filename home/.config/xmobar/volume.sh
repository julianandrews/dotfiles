#/usr/bin/env sh

PACTL_SCRIPT=/home/julian/.config/xmobar/pulseaudio-ctl.sh
LOW_VOLUME=35
HIGH_VOLUME=100

info=$($PACTL_SCRIPT full-status)
volume=$(echo $info | cut -d ' ' -f 1)
muted=$(echo $info | cut -d ' ' -f 2)
[ "$muted" = 'yes' ] && icon_string='<fn=1></fn>' || icon_string='<fn=1></fn>'
if [ "$muted" = 'yes' ]; then
  color="#DC322F"
else
  if [ "$volume" -le "$LOW_VOLUME" ]; then
    color="#586e75"
  elif [ "$volume" -gt "$HIGH_VOLUME" ]; then
    color="#b58900"
  else
    color="#268bd2"
  fi
fi

echo "<action=\`$PACTL_SCRIPT mute\` button=2><action=\`$PACTL_SCRIPT down\` button=3><action=\`$PACTL_SCRIPT up\` button=1><fc=${color}>$icon_string ${volume}</fc>%</action></action></action>"
