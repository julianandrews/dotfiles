alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim='nvim'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mash='python manage.py shell_plus --use-pythonrc'
alias mars='WERKZEUG_DEBUG_PIN=off python manage.py runserver_plus'

function pcat() {
    pygmentize -f terminal256 "${1:--}" 2> /dev/null || cat "${1:--}"
}

function pless(){
  pcat "$1" | less -R
}

function rgv() {
    vim -q <(rg -n "$@")
}

function ptouch() {
    while [ -n "$1" ]
    do
      install -D -m 644 /dev/null "$1"
      shift
    done
}
