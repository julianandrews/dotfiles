#!/bin/env sh

SERVER='gargantua-two'

check_mail() {
  ssh "$1" '[ -s /var/mail/julian ] && echo mail'
}

mail=$(check_mail "$SERVER")
if [ $? = 255 ]
then
  # ssh returns 255 on a failed connection
  status='<fc=#cb4b16><fn=1> </fn></fc>'
elif [ -z "$mail" ]
then
  status='<fc=#268bd2>✓</fc>'
else
  status='<fc=#b48900><fn=1> </fn></fc>'
fi

echo "<action=\`urxvt -e ssh gargantua-two\`>G2$status</action>"
