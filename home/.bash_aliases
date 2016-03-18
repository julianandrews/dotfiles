alias ll='ls -alF'
alias la='ls -A'
alias m='python manage.py'
alias mash='python manage.py shell_plus --use-pythonrc'

function pless(){
  pcat "$1" | less -R
}
