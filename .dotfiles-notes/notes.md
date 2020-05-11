Installation/Setup
==================

Dotfiles
--------

Use the https url since on a new machine I won't yet have ssh keys in place.

    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    git clone --bare https://github.com/julianandrews/dotfiles.git $HOME/.dotfiles
    dotfiles config --local status.showUntrackedFiles no
    dotfiles remote set-url origin git@github.com:julianandrews/dotfiles.git
    dotfiles checkout

It will probably be necessary to remove existing files (after possibly backing
them up), and then rerun `dotfiles checkout`.

Python Packages
---------------

    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
      python3 get-pip.py --user && \
      rm get-pip.py
    python3 -m pip install --user gmailcount[secretservice] pillow pygments \
      pyxdg requests six virtualenv virtualenvwrapper \
      python-language-server

Also install https://github.com/john2x/solarized-pygment to user space (python3).

Neovim
------
    :CocInstall coc-python
    :CocInstall coc-rls

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

    sudo cp ~/.dotfiles-notes/acpi/actions/* /etc/acpi/actions
    sudo cp ~/.dotfiles-notes/acpi/events/* /etc/acpi/events
    sudo systemctl restart acpid.service

UDev rules (monitor hotplug, u2f key)
-------------------------------------

    sudo cp ~/.dotfiles-notes/udev-rules/* /etc/udev/rules.d/
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
Install tarsnap

    sudo update-alternatives --set editor /usr/bin/nvim
    sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt
    sudo update-alternatives --set x-www-browser /usr/bin/chromium
    xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet

Todo
----
Laptop lid open/close on ac power
    should call set-monitors
    set-monitors should do the right thing based on lid state
Fix volumeup/down media keys
