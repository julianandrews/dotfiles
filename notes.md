Packages
========

Tasks
-----
task-laptop task-ssh-server

Packages
--------
build-essential cmake checkinstall libncurses5-dev python python-dev python3 python3-dev ruby ruby-dev python-flake8 python-requests virtualenv virtualenvwrapper git xorg xinput alsa-utils pulseaudio wicd i3 xmonad xmobar lightdm lxappearance faenza-icon-theme chromium feh kupfer xfce4-terminal

Home only
---------
ecryptfs-utils electrum gourmet slashem vlc

Compiling
========

Vim
---
`python-config-dir` may not be universal.
    ./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/
    sudo checkinstall

YouCompleteMe
-------------

    ~/.vim/bundle/YouCompleteMe/install.sh

Command-T
---------

    cd .vim/bundle/commend-t/ruby/command-t
    ruby extconf.rb
    make
