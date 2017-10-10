Installation/Setup
==================

Dotfiles
--------
    git clone https://github.com/julianandrews/dotfiles.git
    git remote set-url origin git@github.com:julianandrews/dotfiles.git
    mv dotfiles ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh

Using the https url to clone avoids having to configure ssh just to get the
dotfiles.

Lightdm
-------
Edit `/etc/lightdm/lightdm.conf`. Under `[Seat:*]` set:

    * `greeter-hide-users=false`
    * `xserver-command=X -ardelay 250 -arinterval 20`

Misc Setup
----------
sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt

Todo
----
xsslock
remap capslock
vim setup fiddling
