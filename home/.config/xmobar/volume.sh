#/usr/bin/env sh

low_volume=35
high_volume=100
max_volume=150
increment=${2:-5}

info=$(pacmd list-sinks)
sink=$(echo "$info" | awk '/\* index:/{ print $3 }')
volume=$(echo "$info" | grep -A 15 '* index' | awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g')
muted=$(echo "$info" | grep -A 15 '* index' | awk '/muted:/{ print $2 }')

case "$1" in
  up)
    [ "$(( $volume + $increment ))" -gt "$max_volume" ] && increment="$(( $max_volume - $volume ))"
    pactl set-sink-volume "$sink" +$increment% 
    volume=$(( volume + $increment ))
    ;;
  down)
    [ "$increment" -gt "$volume" ] && increment="$volume"
    pactl set-sink-volume "$sink" -$increment%
    volume=$(( volume - $increment ))
    ;;
  mute)
    pactl set-sink-mute "$sink" toggle
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

echo "<action=\`$this_script mute\` button=2><action=\`$this_script down\` button=3><action=\`$this_script down 1\` button=5><action=\`$this_script up\` button=1><action=\`$this_script up 1\` button=4><fc=${color}>$icon_string ${volume}</fc>%</action></action></action></action></action>" > $pipe
