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
      python2 get-pip.py --user && rm get-pip.py
    python2 -m pip install --user notify2
    python3 -m pip install --user bpython gmailcount[secretservice] pillow pygments pyxdg \
      requests six virtualenv virtualenvwrapper

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

Auto lock on suspend
------------------

    sudo -e /etc/systemd/system/screen-lock.service

        [Unit]
        Description=screen-lock
        After=suspend.target

        [Service]
        User=julian
        Type=forking
        Environment=DISPLAY=:0
        ExecStart=/home/julian/.local/bin/screen-lock
        StandardOutput=syslog

        [Install]
        WantedBy=multi-user.target sleep.target

    sudo systemctl enable screen-lock.service

Reset xset options on wake
--------------------------

    sudo -e /etc/systemd/system/xset-on-wake.service

        [Unit]
        Description=Reset xset options on wake
        After=suspend.target
        After=hibernate.target

        [Service]
        User=julian
        Environment=DISPLAY=:0
        ExecStart=/home/julian/.local/bin/xconfig

        [Install]
        WantedBy=suspend.target
        WantedBy=hibernate.target

  sudo systemctl enable xset-on-wake.service

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

Tarsnap
-------

    sudo -e /etc/cron.daily/tarsnap-backup

        #!/usr/bin/env sh
        su julian -c /home/julian/.local/bin/tarsnap-backup

    sudo chmod a+x /etc/crond.daily/tarsnap-backup

Misc Setup
----------
* `sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt`
* `sudo update-alternatives --set x-www-browser /usr/bin/chromium`
* `xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet`
* Edit `/etc/lightdm/lightdm.conf`. Set `greeter-hide-users=false` under `[Seat:*]`
