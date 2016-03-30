Installation/Setup
========================

Dotfiles
--------

    git clone https://github.com/julianandrews/dotfiles.git
    git remote set-url origin git@github.com:julianandrews/dotfiles.git
    mv dotfiles ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh

Using the https url to clone avoids having to configure ssh just to get the
dotfiles.

Vim
---

    apt-get source vim
    cd vim-*
    ./configure --with-features=normal --with-x --enable-multibyte \
      --enable-rubyinterp --enable-pythoninterp --enable-perlinterp \
      --enable-luainterp
    sudo apt-get remove vim-common vim-tiny
    sudo checkinstall
    sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
    sudo update-alternatives --set editor /usr/local/bin/vim

For the `checkinstall` step, setting the package name to `vim-custom` or
something like that avoids potential conflicts.

After installation run `:PluginInstall` in vim, and then from the shell:

    ~/.vim/bundle/YouCompleteMe/install.sh
    cd ~/.vim/bundle/command-t/ruby/command-t
    ruby extconf.rb
    make

Python Packages
---------------

    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
      && python get-pip.py --user && python3 get-pip.py --user \
      && rm get-pip.py
    pip install --user virtualenv virtualenvwrapper
    pip3 install --user requests pillow pyxdg pygments gmailcount[secretservice]

Also install https://github.com/john2x/solarized-pygment to user space.

Node + Eslint
-------------

    curl <tarball_url> | tar -xz
    cd <node_dir>
    ./configure --prefix=$HOME/.local
    make
    make install
    npm install -g eslint

Auto lock on suspend
------------------

    sudo -e /etc/systemd/system/screen-lock.service

        [Unit]
        Description=screen-lock
        Before=sleep.target

        [Service]
        User=julian
        Type=forking
        Environment=DISPLAY=:0
        ExecStart=/home/julian/.local/bin/screen-lock

        [Install]
        WantedBy=sleep.target

    sudo systemctl enable screen-lock.service

Monitor Hotplugging
-------------------

    sudo -e /etc/udev/rules.d/70-monitor.rules

        SUBSYSTEM=="drm", ACTION=="change", RUN+="/home/julian/.local/bin/set-monitors"

    sudo udevadm control --reload-rules

Yubikey
-------

    sudo -e /etc/udev/rules.d/70-u2f.rules

        # this udev file should be used with udev 188 and newer
        ACTION!="add|change", GOTO="u2f_end"

        # Yubico YubiKey
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0402|0403|0406|0407|0410", TAG+="uaccess"

        # Happlink (formerly Plug-Up) Security KEY
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="f1d0", TAG+="uaccess"

        #  Neowave Keydo and Keydo AES
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1e0d", ATTRS{idProduct}=="f1d0|f1ae", TAG+="uaccess"

        # HyperSecu HyperFIDO
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="096e", ATTRS{idProduct}=="0880", TAG+="uaccess"

        LABEL="u2f_end"

  sude udevadm control --reload-rules

Misc Setup
----------
* `sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt`
* `xdg-settings set default-web-browser chromium.desktop`
* `xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet`
* Edit `/etc/lightdm/lightdm.conf`. Set `greeter-hide-users=false` under [SeatDefaults]
* In Weechat `/script install lnotify.py`
* `mkdir -p ~/.weechat/python/autoload`
* `ln -s "$(realpath ~/.weechat/python/i3lock_away.py)" ~/.weechat/python/autoload/`

Home Computer Specific
----------------------
* Add `acpi_backlight=vendor` to `GRUB_CMDLINE_LINUX_DEFAULT` in
  `/etc/default/grub` and run `sudo update-grub`
* Edit `/etc/pulse/defaul.pa`. Add `load-module module-switch-on-connect` to end.

Issues
======
* XMonad layout resizing
* XMonad screen cycling reversed
