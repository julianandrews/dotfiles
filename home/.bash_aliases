# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias m='python manage.py'
alias mash='python manage.py shell_plus --use-pythonrc'
alias mars='WERKZEUG_DEBUG_PIN=off python manage.py runserver_plus'

function pless(){
  pcat "$1" | less -R
}

function cdp() {
  file=$(python -c "import ${1}; print(${1}.__file__)")
  pushd "$(dirname $(realpath "$file"))"
}
