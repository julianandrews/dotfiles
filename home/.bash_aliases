alias m='python manage.py'
alias mash='python manage.py shell_plus --use-pythonrc'
alias mars='python manage.py runserver_plus'

function pless(){
  pcat "$1" | less -R
}
