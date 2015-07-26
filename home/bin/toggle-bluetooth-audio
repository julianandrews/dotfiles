#!/bin/bash

function move_to_sink {
  pactl set-default-sink "$1"
  for sink_input in $(pactl list short sink-inputs | cut -f 1)
  do
    pactl move-sink-input "$sink_input" "$1"
  done
}

sinks=$(pactl list short sinks)
default_sink_name=$(pactl info | grep "Default Sink" | cut -d ' ' -f 3)
default_sink=$(echo "$sinks" | grep $default_sink_name | cut -f 1)
main_sink=$(echo "$sinks" | grep analog-stereo | cut -f 1)
bluetooth_sink=$(echo "$sinks" | grep bluez_sink | cut -f 1)

if [ ! "$bluetooth_sink" ]
then
  echo "Bluetooth sink not found"
elif [ $default_sink -eq $main_sink ]
then
  move_to_sink "$bluetooth_sink"
else
  move_to_sink "$main_sink"
fi
