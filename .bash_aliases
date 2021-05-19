alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

function ptouch() {
    while [ -n "$1" ]
    do
      install -D -m 644 /dev/null "$1"
      shift
    done
}

# Usage:
#
# Set password:
# secret-tool store --label="msmtp password for jandrews271@gmail.com" service msmtp username jandrews271@gmail.com
#
# Send mail:
# echo "Message Body" | send-gmail jandrews271 thedobos@gmail.com "My Subject"
#
# Send text message to a Google Fi subscriber:
# echo "Message Body" | send-gmail jandrews271 5551234567@msg.fi.google.com "My Subject"
send-gmail() {
  local user="$1"
  local to="$2"
  local subject="$3"
  local message_body=$(</dev/stdin)
  msmtp \
    --host smtp.gmail.com \
    --port 587 \
    --tls=on \
    --tls-starttls=on \
    --auth=on \
    --user "$user" \
    --from "$user@gmail.com" \
    --passwordeval "secret-tool lookup service msmtp username $user@gmail.com" \
    "$to" << EOF
From: $user@gmail.com
To: $to
Subject: $subject

$message_body
EOF
}
