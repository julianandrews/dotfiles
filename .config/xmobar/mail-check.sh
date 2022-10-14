#!/usr/bin/env sh

if [ -s "/var/mail/$USER" ]; then
  status='<fc=#b48900><fn=1></fn></fc>'
else
  status='<fc=#268bd2>✓</fc>'
fi

echo "<fn=1></fn> $status"
