#!/bin/env sh

SERVER='gargantua-two'

check_mail() {
  ssh "$1" '[ -s /var/mail/julian ] && echo mail'
}

if [ $(check_mail "$SERVER") ]
then
  status='<fc=#b48900><fn=1> </fn></fc>'
else
  status='<fc=#268bd2>✓</fc>'
fi

echo "<action=\`urxvt -e ssh gargantua-two\`>G2$status</action>"
