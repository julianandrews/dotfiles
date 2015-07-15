Packages
========

Tasks
-----
task-laptop

Packages
--------
build-essential cmake checkinstall libncurses5-dev python python-dev python3 python3-dev ruby ruby-dev python-flake8 python-requests virtualenv virtualenvwrapper git xorg xinput alsa-utils pulseaudio wicd i3 xmonad xmobar lightdm lxappearance faenza-icon-theme chromium feh kupfer xfce4-terminal libnotify-bin httpie tree evince thunar gnumeric libvorbisfile3 ristretto xarchiver thunar-archive-plugin pepperflashplugin-nonfree ttf-mscorefonts-installer ttf-dejavu pm-utils gnome-keyring

Work only
---------
pidgin

Home only
---------
ecryptfs-utils electrum gourmet slashem vlc transmission-cli transmission-gtk gimp nvidia-driver bluez-firmware pavucontrol bluez-tools libqt4-dev libphonon-dev libxml2-dev libxslt1-dev qtmobility-dev

Debs
----
google-musicmanager-beta

Vim
========

Compilation
---
Install with:

    ./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu --prefix=/usr
    sudo checkinstall

If using dotfiles, follow up with

    git submodule update --init --recursive


`python-config-dir` may not be universal.

YouCompleteMe
-------------
Install with:

    ~/.vim/bundle/YouCompleteMe/install.sh

Command-T
---------
Install with:

    cd .vim/bundle/command-t/ruby/command-t
    ruby extconf.rb
    make

Other Installation/Setup
========================

Pip
---
Install with(quick easy way to get latest version):

    sudo apt-get install python-pip
    sudo pip install --upgrade pip
    sudo apt-get remove python-pip && sudo apt-get autoremove

Suspend Privileges
------------------
Setup with:

    sudo visudo
    Add
      julian  ALL = NOPASSWD: /usr/sbin/pm-suspend
      julian  ALL = NOPASSWD: /sbin/shutdown
      julian  ALL = NOPASSWD: /sbin/reboot

Misc
----
Set Kupfer style to remove rounded corners

Issues
======
install.sh
----------

* Doesn't handle prexisting directory symlinks well.
* Backup seems a little wonky.
