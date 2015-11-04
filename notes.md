Packages
========
Packages
--------
build-essential cmake checkinstall libncurses5-dev python python-dev python3 python3-dev libperl-dev ruby ruby-dev python-flake8 python-requests git xorg xinput alsa-utils pulseaudio wicd i3 lightdm lxappearance faenza-icon-theme chromium feh kupfer xfce4-terminal libnotify-bin httpie tree evince gnumeric libvorbisfile3 p7zip-full unzip unrar pepperflashplugin-nonfree pm-utils gnome-keyring postgresql postgresql-server-dev-9.4 silversearcher-ag ranger xorg-dev sqlite i3blocks htop libvirt-bin qemu-kvm bridge-utils virt-manager iptables-persistent netselect-apt openjdk-8-jre apg scrot imagemagick xautolock libjpeg-dev python-pygments pv libxslt-dev libxml2-dev libvirt-dev zlib1g-dev vagrant cython libqt4-dev nfs-kernel-server jq iceweasel flashplugin-nonfree cups cups-client

Home only
---------
electrum gourmet slashem vlc transmission-cli transmission-gtk gimp bluez-firmware pavucontrol pulseaudio-module-bluetooth bluez-tools libqt4-dev libphonon-dev libxml2-dev libxslt1-dev qtmobility-dev ffmpeg slashem guvcview easytag sgt-puzzles

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

Suspend/Shutdown Privileges
------------------
Setup with:

    sudo visudo
    Add
      julian  ALL = NOPASSWD: /usr/sbin/pm-suspend
      julian  ALL = NOPASSWD: /sbin/shutdown

Misc Setup
----------
* `curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py --user && rm get-pip.py`
* `pip install --user virtualenv virtualenvwrapper`
* Edit `/etc/lightdm/lightdm.conf`. Set `greeter-hide-users=false` under [SeatDefaults]
* Set Kupfer style to remove rounded corners
* Run lxappearance
* Run exo-preferred-applications to configure xfce4-terminal link handling

Home Computer Specific
----------------------
* Add `acpi_backlight=vendor` to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub` and run `sudo update-grub`
* xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet
* Edit `/etc/pulse/defaul.pa`. Add `load-module module-switch-on-connect` to end.

Issues
======
install.sh
----------
* Doesn't handle prexisting directory symlinks well.
* Backup seems a little wonky.
