#/usr/bin/env sh

command_prefix="sudo -u julian XDG_RUNTIME_DIR=/run/user/1000 "
low_volume=35
high_volume=100
max_volume=150
increment=${2:-5}

info=$(${command_prefix}pacmd list-sinks)
if [ "$info" == "" ]; then
  exit 1
fi
sink=$(echo "$info" | awk '/\* index:/{ print $3 }')
volume=$(echo "$info" | grep -A 15 '* index' | awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g')
muted=$(echo "$info" | grep -A 15 '* index' | awk '/muted:/{ print $2 }')

case "$1" in
  button/volumeup)
    [ "$(( $volume + $increment ))" -gt "$max_volume" ] && increment="$(( $max_volume - $volume ))"
    ${command_prefix}pactl set-sink-volume "$sink" +$increment% 
    volume=$(( volume + $increment ))
    ;;
  button/volumedown)
    [ "$increment" -gt "$volume" ] && increment="$volume"
    ${command_prefix}pactl set-sink-volume "$sink" -$increment%
    volume=$(( volume - $increment ))
    ;;
  button/mute)
    ${command_prefix}pactl set-sink-mute "$sink" toggle
    [ "$muted" = 'yes' ] && muted='no' || muted='yes'
    ;;
esac

[ "$muted" = 'yes' ] && icon_string='<fn=1></fn>' || icon_string='<fn=1></fn>'
if [ "$muted" = 'yes' ]; then
  color="#DC322F"
else
  if [ "$volume" -le "$low_volume" ]; then
    color="#586e75"
  elif [ "$volume" -gt "$high_volume" ]; then
    color="#b58900"
  else
    color="#268bd2"
  fi
fi

pipe=/tmp/.volume-pipe
this_script=$(realpath $0)
[ ! -p "$pipe" ] && mkfifo "$pipe"

echo "<action=\`$this_script mute\` button=2><action=\`$this_script down\` button=3><action=\`$this_script down 1\` button=5><action=\`$this_script up\` button=1><action=\`$this_script up 1\` button=4><fc=${color}>$icon_string ${volume}</fc>%</action></action></action></action></action>" > "$pipe"
