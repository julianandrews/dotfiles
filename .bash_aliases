alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/repo --work-tree=$HOME'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

[ -x "$(which bat)" ] && alias cat='bat --theme "Solarized (dark)" --no-pager --style plain'

    # Generate a url safe password with ~120 bits of entropy.
    password() {
      local length=${1:-"20"}
      cat /dev/urandom | tr -dc A-Za-z0-9~_- | head -c $length && echo
    }

    # Generate a url safe password that:
    # - begins with a letter, and has at least
    # - one uppercase letter,
    # - one lowercase letter,
    # - one digit, and
    # - one special character.
    stupid_password() {
      while :
      do
        local length=${1:-"10"}
        local pass=$(password "$length")
        [[ $pass != *[~_-]* ]] && continue
        [[ $pass != [A-Za-z]* ]] && continue
        [[ $pass != *[A-Z]* ]] && continue
        [[ $pass != *[a-z]* ]] && continue
        [[ $pass != *[0-9]* ]] && continue
        echo "$pass"
        break
      done
    }

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

alias ksh='kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh'

source "$HOME/.bash_aliases_work"
