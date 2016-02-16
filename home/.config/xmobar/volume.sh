#~/bin/sh
PACTL_SCRIPT=/home/julian/.config/xmobar/pulseaudio-ctl
LOW_VOLUME=50
HIGH_VOLUME=100

info=$($PACTL_SCRIPT full-status)
volume=$(echo $info | cut -d ' ' -f 1)
muted=$(echo $info | cut -d ' ' -f 2)
if [ "$muted" = 'yes' ]; then
  color="#DC322F"
else
  if [ "$volume" -le "$LOW_VOLUME" ]; then
    color="#6C71C4"
  elif [ "$volume" -gt "$HIGH_VOLUME" ]; then
    color="#CB4B16"
  else
    color="#2AA198"
  fi
fi

echo "<action=\`$PACTL_SCRIPT mute\` button=2><action=\`$PACTL_SCRIPT down\` button=3><action=\`$PACTL_SCRIPT up\` button=1>♫<fc=${color}>${volume}</fc>%</action></action></action>"
