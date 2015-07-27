Packages
========

Setup
-----
Add `contrib` and `non-free` to `/etc/apt/sources.list`. E.g.:

    deb http://http.debian.net/debian/ jessie main contrib non-free

Packages
--------
build-essential cmake checkinstall libncurses5-dev python python-dev python3 python3-dev ruby ruby-dev python-flake8 python-requests virtualenv virtualenvwrapper git xorg xinput alsa-utils pulseaudio wicd i3 lightdm lxappearance faenza-icon-theme chromium feh kupfer xfce4-terminal libnotify-bin httpie tree evince gnumeric libvorbisfile3 xarchiver pepperflashplugin-nonfree ttf-mscorefonts-installer ttf-dejavu pm-utils gnome-keyring postgresql postgresql-server-dev-9.4 silversearcher-ag ranger xorg-dev sqlite i3blocks unrar parallel

Work only
---------
pidgin

Home only
---------
ecryptfs-utils electrum gourmet slashem vlc transmission-cli transmission-gtk gimp nvidia-driver bluez-firmware pavucontrol pulseaudio-module-bluetooth bluez-tools libqt4-dev libphonon-dev libxml2-dev libxslt1-dev qtmobility-dev ffmpeg slashem guvcview

Debs
----
google-musicmanager-beta google-talkplugin

Other Installation/Setup
========================
Vim
---

###Compilation
Install with:

    ./configure --with-features=normal --with-x --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp --prefix=/usr
    sudo checkinstall
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
    sudo update-alternatives --set editor /usr/bin/vim

If using dotfiles, follow up with

    git submodule update --init --recursive

###YouCompleteMe
Install with:

    ~/.vim/bundle/YouCompleteMe/install.sh

###Command-T
Install with:

    cd .vim/bundle/command-t/ruby/command-t
    ruby extconf.rb
    make

Pip
---
Install with(quick easy way to get latest version):

    sudo apt-get install python-pip
    sudo pip install --upgrade pip
    sudo apt-get remove python-pip && sudo apt-get autoremove

Suspend/Shutdown Privileges
------------------
Setup with:

    sudo visudo
    Add
      julian  ALL = NOPASSWD: /usr/sbin/pm-suspend
      julian  ALL = NOPASSWD: /sbin/shutdown

Steam
-----
Install with:

    dpkg --add-architecture i386
    sudo apt-get install steam
    sudo apt-get install libgl1-nvidia-glx:i386

lightdm Config
--------------
Edit `/etc/lightdm/lightdm.conf`. Set `greeter-hide-users=false` and `greeter-show-manual-login=false` under [SeatDefaults]

Grub2 Config
-----------
* Edit `/etc/default/grub`
* run `sudo update-grub`

Misc
----
* Set Kupfer style to remove rounded corners
* Run lxappearance
* Add `load-module module-switch-on-connect` to end of `/etc/pulse/default.pa`

Issues
======
install.sh
----------
* Doesn't handle prexisting directory symlinks well.
* Backup seems a little wonky.

Media Keys
----------
* XF86Tools (music player?)
* XF86Search
* XF86Menu
* XF86MonBrightnessDown
* XF86MonBrightnessUp
* XF86Display
* XF86Battery

Misc
----
* USB/monitor auto
