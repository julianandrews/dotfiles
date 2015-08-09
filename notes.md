Packages
========
Packages
--------
build-essential cmake checkinstall libncurses5-dev python python-dev python3 python3-dev ruby ruby-dev python-flake8 python-requests git xorg xinput alsa-utils pulseaudio wicd i3 lightdm lxappearance faenza-icon-theme chromium feh kupfer xfce4-terminal libnotify-bin httpie tree evince gnumeric libvorbisfile3 p7zip-full unzip unrar pepperflashplugin-nonfree pm-utils gnome-keyring postgresql postgresql-server-dev-9.4 silversearcher-ag ranger xorg-dev sqlite i3blocks htop irssi mcabber

Home only
---------
electrum gourmet slashem vlc transmission-cli transmission-gtk gimp bluez-firmware pavucontrol pulseaudio-module-bluetooth bluez-tools libqt4-dev libphonon-dev libxml2-dev libxslt1-dev qtmobility-dev ffmpeg slashem guvcview easytag

Debs
----
google-talkplugin

Other Installation/Setup
========================
Vim
---

###Compilation
Install with:

    sudo apt-get remove vim-common vim-tiny
    ./configure --with-features=normal --with-x --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp --prefix=/usr
    sudo checkinstall
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
    sudo update-alternatives --set editor /usr/bin/vim

###YouCompleteMe
Install with:

    ~/.vim/bundle/YouCompleteMe/install.sh

###Command-T
Install with:

    cd .vim/bundle/command-t/ruby/command-t
    ruby extconf.rb
    make

Suspend/Shutdown Privileges
------------------
Setup with:

    sudo visudo
    Add
      julian  ALL = NOPASSWD: /usr/sbin/pm-suspend
      julian  ALL = NOPASSWD: /sbin/shutdown
      julian  ALL = NOPASSWD: /sbin/reboot

Misc
----
* Install pip
* `sudo pip install virtualenv virtualenvwrapper`
* Edit `/etc/pulse/defaul.pa`. Add `load-module module-switch-on-connect` to end.
* Edit `/etc/lightdm/lightdm.conf`. Set `greeter-hide-users=false` under [SeatDefaults]
* Config Grub2
* xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet
* Set Kupfer style to remove rounded corners
* Run lxappearance
* Run exo-preferred-applications to configure xfce4-terminal link handling
* Install Steam

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
* XF86Display
* XF86Battery

Misc
----
* monitor auto
* brightness tweaks
