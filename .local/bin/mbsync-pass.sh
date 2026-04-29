#!/bin/sh

systemd-creds cat purelymail-app-password 2>/dev/null || \
    pass show personal/purelymail/app-password
