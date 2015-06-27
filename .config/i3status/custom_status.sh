#!/bin/bash

if [ $HOSTNAME == 'orpheus' ]
then
  EMAIL='jandrews@fusionbox.com'
else
  EMAIL='jandrews271@gmail.com'
fi

EMAIL_COLOR='#OOFFOO'

function gmail {
  count=$(gmail-count -u $1)
  if [ "$count" == "0" ]; then
    color='#585858'
  elif [ "$count" == "?" ]; then
    color='#FF0000'
  else
    color=$2
  fi
  echo "{\"name\":\"$1\",\"color\":\"$color\",\"full_text\":\"✉ $count\"}"
}

function prepend_gmail {
  echo "[$(gmail $EMAIL $EMAIL_COLOR),${1:1}"
}

function rewrite_stream {
  read line && echo $line && read line && echo $line
  read line && echo "$(prepend_gmail "$line")"
  while :
  do
    read line && echo ",$(prepend_gmail "${line:1}")"
  done
}

i3status | rewrite_stream
