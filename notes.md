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

    * `xserver-command=X -ardelay 250 -arinterval 20`

Python
------
    python3 -m pip install --user pillow

Crontab
-------
`0 */3 * * * DISPLAY=:0.0 ${HOME}/.local/bin/artsandculturedesktop > /tmp/artsandculturedesktop.log 2>&1`

Vim
---
Install clang-include-fixer (go/clang-include-fixer)
Install vim-plug
Run :PlugInstall

Misc Setup
----------
sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt
/google/data/ro/teams/fig/install.sh
Install fzf
Install ripgrep

Todo
----
xsslock
vim setup fiddling
