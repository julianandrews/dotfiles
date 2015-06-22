#!/bin/bash

EMAILS=('jandrews271@gmail.com','#00FF00' 'jandrews@fusionbox.com','#0000FF')

function gmail {
  count=`gmail-count -u $1`
  if [ "$count" == "0" ]; then
    color="#585858"
  elif [ "$count" == "?" ]; then
    color="#FF0000"
  else
    color=$2
  fi
  echo "{\"color\":\"$color\",\"full_text\":\"✉ $count\"}"
}

i3status | (read line && echo $line && read line && echo $line && read line && echo $line && while :
do
  read line
  line=${line:2}
  OLDIFS=$IFS
  for args in ${EMAILS[@]}; do
    IFS=','
    line=`gmail $args`,$line
    IFS=$OLDIFS
  done
  echo ",[$line"
done)
