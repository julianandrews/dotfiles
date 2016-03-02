Installation/Setup
========================

Dotfiles
--------

    git clone https://github.com/julianandrews/dotfiles.git
    mv dotfiles ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh
    git remote set-url origin git@github.com:julianandrews/dotfiles.git

Using the https url to clone avoids having to configure ssh keys manually.

Vim
---

###Installation

    apt-get source vim
    cd vim-*
    ./configure --with-features=normal --with-x --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp
    sudo apt-get remove vim-common vim-tiny
    sudo checkinstall
    sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
    sudo update-alternatives --set editor /usr/local/bin/vim

For the `checkinstall` step, setting the package name to `vim-custom` or something like that avoids potential conflicts.

###YouCompleteMe

    ~/.vim/bundle/YouCompleteMe/install.sh

###Command-T

    cd ~/.vim/bundle/command-t/ruby/command-t
    ruby extconf.rb
    make

Node + Eslint
-------------

    curl https://nodejs.org/dist/v5.6.0/node-v5.6.0.tar.gz | tar -xz
    cd node-v5.6.0/
    ./configure --prefix=$HOME/.local
    make
    make install
    npm install -g eslint

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
* `curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py --user && python3 get-pip.py && rm get-pip.py`
* `pip install --user virtualenv virtualenvwrapper pygments`
* `pip3 install --user requests pillow pyxdg`
* install https://github.com/john2x/solarized-pygment
* Edit `/etc/lightdm/lightdm.conf`. Set `greeter-hide-users=false` under [SeatDefaults]
* Set Kupfer style to remove rounded corners
* Run lxappearance
* `xdg-settings set default-web-browser chromium.desktop`
* In Weechat `/script install lnotify.py`
* `xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet`
* `sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt`

Home Computer Specific
----------------------
* Add `acpi_backlight=vendor` to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub` and run `sudo update-grub`
* Edit `/etc/pulse/defaul.pa`. Add `load-module module-switch-on-connect` to end.

Issues
======
install.sh
----------
* Doesn't handle prexisting directory symlinks well.
* Backup seems a little wonky.
