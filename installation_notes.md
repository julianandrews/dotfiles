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
something like that avoids potential conflicts. After installation run
`:PluginInstall` in vim, and then from the shell:

    ~/.vim/bundle/YouCompleteMe/install.sh
    cd ~/.vim/bundle/command-t/ruby/command-t
    ruby extconf.rb
    make

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

Python Packages
---------------

    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
      && python get-pip.py --user && python3 get-pip.py --user \
      && rm get-pip.py
    pip install --user virtualenv virtualenvwrapper
    pip3 install --user requests pillow pyxdg pygments gmailcount[secretservice]

Also install https://github.com/john2x/solarized-pygment to user space.

Monitor Hotplugging
-------------------

    sudo -e /etc/udev/rules.d/70-monitor-rules

        SUBSYSTEM=="drm", ACTION=="change, RUN+="/home/julian/.local/bin/set-monitors"

    sudo udevadm control --reload-rules

Misc Setup
----------
* `sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt`
* `xdg-settings set default-web-browser chromium.desktop`
* `xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet`
* Edit `/etc/lightdm/lightdm.conf`. Set `greeter-hide-users=false` under [SeatDefaults]
* Run lxappearance
* In Weechat `/script install lnotify.py`

Home Computer Specific
----------------------
* Add `acpi_backlight=vendor` to `GRUB_CMDLINE_LINUX_DEFAULT` in
  `/etc/default/grub` and run `sudo update-grub`
* Edit `/etc/pulse/defaul.pa`. Add `load-module module-switch-on-connect` to end.

Issues
======
* install.sh deletes preexisting symlinks
* xmonad layout resizing
* Xmonad screen cycling reversed
