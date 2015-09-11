alias ll='ls -alF'
alias la='ls -A'
alias m='python manage.py'
alias mr='python manage.py runserver_plus'
alias pcat='pygmentize -f terminal256 -O style=vim'

function pless(){
  pcat "$1" | less -R
}
