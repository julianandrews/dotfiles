Installation/Setup
==================

Dotfiles
--------

Use the https url since on a new machine I won't yet have ssh keys in place.

    git clone https://github.com/julianandrews/dotfiles.git
    git remote set-url origin git@github.com:julianandrews/dotfiles.git
    mv dotfiles ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh

Vim
---

    apt-get source vim
    cd vim-*
    ./configure --with-features=normal --with-x --enable-python3interp=dynamic
    sudo apt-get remove vim-common vim-tiny
    sudo checkinstall
    sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
    sudo update-alternatives --set editor /usr/local/bin/vim

For the `checkinstall` step, setting the package name to `vim-custom` or
something like that avoids potential conflicts.

Python Packages
---------------

    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
      python3 get-pip.py --user && \
      rm get-pip.py
    python3 -m pip install --user gmailcount[secretservice] pillow pygments \
      pyxdg requests six virtualenv virtualenvwrapper

Also install https://github.com/john2x/solarized-pygment to user space (python3).

Node & Node packages
--------------------

    curl <tarball_url> | tar -xz
    cd <node_dir>
    ./configure --prefix=$HOME/.local
    make
    make install
    npm install -g eslint
    npm install -g tern

Tarsnap
-------

    sudo -e /etc/cron.daily/tarsnap-backup

        #!/usr/bin/env sh
        su julian -c /home/julian/.local/bin/tarsnap-backup

    sudo chmod a+x /etc/crond.daily/tarsnap-backup

ACPI event handlers (backlight, lid, volume)
--------------------------------------------

    sudo cp ~/.dotfiles/acpi/actions/* /etc/acpi/actions
    sudo cp ~/.dotfiles/acpi/events/* /etc/acpi/events
    sudo systemctl restart acpid.service

UDev rules (monitor hotplug, u2f key)
-------------------------------------

    sudo cp ~/.dotfiles/udev-rules/* /etc/udev/rules.d/
    sudo udevadm control --reload-rules

CapsLock->Esc
-------------

Set `XKBOPTIONS="caps:escape"` in `/etc/default/keyboard`

    udevadm trigger --subsystem-match=input --action=change

Lightdm
-------

Edit `/etc/lightdm/lightdm.conf`. Under `[Seat:*]` set:

    * `greeter-hide-users=false`
    * `xserver-command=X -ardelay 250 -arinterval 20`

Rust
----
    curl https://sh.rustup.rs -sSf | sh
    rustup component add rustfmt-preview
    rustup component add rls-preview rust-analysis rust-src

Crontab
-------

`0 */3 * * * DISPLAY=:0.0 ${HOME}/.local/bin/artsandculturedesktop > /tmp/artsandculturedesktop.log 2>&1`

Misc Setup
----------

    sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt
    sudo update-alternatives --set x-www-browser /usr/bin/chromium
    xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet

Todo
----
Laptop lid open/close on ac power
    should call set-monitors
    set-monitors should do the right thing based on lid state
Fix volumeup/down media keys
