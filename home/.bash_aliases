alias ll='ls -alF'
alias la='ls -A'
alias m='python manage.py'

function pless(){
  pcat "$1" | less -R
}
