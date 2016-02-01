Packages
========
Packages
--------
build-essential cmake checkinstall htop httpie tree pv jq p7zip-full unzip unrar pm-utils apg silversearcher-ag netselect-apt feh scrot imagemagick iptables-persistent gnupg nmap macchanger zip exfat-fuse exfat-utils texlive texlive-latex-extra texlive-fonts-extra

libvorbisfile3 libjpeg-dev libxslt-dev libxml2-dev zlib1g-dev libncurses5-dev gettext libssh2-1-dev

git mercurial python python-dev python3 python3-dev cython libperl-dev ruby ruby-dev python-flake8 python-requests python-xdg python-xmpp openjdk-8-jre postgresql postgresql-server-dev-9.4 sqlite exuberant-ctags postgis python3.4 python3.4-dev

lightdm xorg xorg-dev xinput alsa-utils pulseaudio wicd i3 xautolock i3blocks lxappearance faenza-icon-theme libnotify-bin gnome-keyring cups cups-client xmonad xmobar xdotool

xfce4-terminal chromium pepperflashplugin-nonfree kupfer gnumeric pavucontrol weechat

nfs-kernel-server vagrant libvirt-bin qemu-kvm bridge-utils virt-manager libvirt-dev

Work only
---------
mysql-client mysql-server iceweasel libssh2-1-dev

Home only
---------
electrum gourmet slashem vlc transmission-cli transmission-gtk gimp bluez-firmware pulseaudio-module-bluetooth bluez-tools libqt4-dev libphonon-dev qtmobility-dev ffmpeg slashem guvcview easytag sgt-puzzles

Home only Debs
----
google-musicmanager-beta google-talkplugin

Other Installation/Setup
========================
Vim
---

###Compilation
Install with:

    sudo apt-get remove vim-common vim-tiny
    apt-get source vim
    cd vim-*
    ./configure --with-features=normal --with-x --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp
    sudo checkinstall
    sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
    sudo update-alternatives --set editor /usr/local/bin/vim

###YouCompleteMe
Install with:

    ~/.vim/bundle/YouCompleteMe/install.sh

###Command-T
Install with:

    cd ~/.vim/bundle/command-t/ruby/command-t
    ruby extconf.rb
    make

Dotfiles
--------
Install with:

    git clone https://github.com/JulianAndrews/dotfiles.git
    mv dotfiles ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh
    git remote set-url origin git@github.com:JulianAndrews/dotfiles.git

Using the https url to clone avoids having to configure ssh keys manually.

Auto lock on suspend
------------------
Setup with:

    sudo -e /etc/systemd/system/screen-lock.service

        [Unit]
        Description=screen-lock
        Before=sleep.target

        [Service]
        User=julian
        Type=forking
        Environment=DISPLAY=:0
        ExecStart=/home/julian/.local/bin/screen-lock.sh

        [Install]
        WantedBy=sleep.target

    sudo systemctl enable screen-lock.service

Misc Setup
----------
* `curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py --user && rm get-pip.py`
* `pip install --user virtualenv virtualenvwrapper`
* Edit `/etc/lightdm/lightdm.conf`. Set `greeter-hide-users=false` under [SeatDefaults]
* Set Kupfer style to remove rounded corners
* Run lxappearance
* Run exo-preferred-applications to configure xfce4-terminal link handling
* xdg-settings set default-web-browser chromium.desktop

Home Computer Specific
----------------------
* Add `acpi_backlight=vendor` to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub` and run `sudo update-grub`
* xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet
* Edit `/etc/pulse/defaul.pa`. Add `load-module module-switch-on-connect` to end.
* In Weechat `/script install lnotify.py`

Issues
======
install.sh
----------
* Doesn't handle prexisting directory symlinks well.
* Backup seems a little wonky.
