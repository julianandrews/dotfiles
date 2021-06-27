Installation/Setup
==================

Dotfiles
--------

Use the https url since on a new machine I won't yet have ssh keys in place.

```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/julianandrews/dotfiles.git $HOME/.dotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles remote set-url origin git@github.com:julianandrews/dotfiles.git
dotfiles checkout
```

It will probably be necessary to remove existing files (after possibly backing
them up), and then rerun `dotfiles checkout`.

FZF
---

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

Neovim
------

```
sudo mkdir /opt/bin
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage | sudo tee /opt/bin/nvim >/dev/null
sudo chmod a+x /opt/bin/nvim
sudo update-alternatives --install /usr/bin/editor editor /opt/bin/nvim 0
sudo update-alternatives --set editor /opt/bin/nvim
```

In nvim:
:PlugInstall

Python Packages
---------------

```
curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && python3 /tmp/get-pip.py --user
python3 -m pip install --user black gmailcount[secretservice] pillow pygments pylint \
  pyxdg requests six virtualenv virtualenvwrapper python-language-server
```


Tarsnap
-------

```
curl -sSfL https://pkg.tarsnap.com/tarsnap-deb-packaging-key.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/tarsnap-archive-keyring.gpg add -
echo "deb http://pkg.tarsnap.com/deb/$(lsb_release -s -c) ./" | sudo tee /etc/apt/sources.list.d/tarsnap.list
sudo apt update
sudo apt install tarsnap
```

sudo -e /etc/cron.daily/tarsnap-backup

    #!/usr/bin/env sh
    su julian -c /home/julian/.local/bin/tarsnap-backup

sudo chmod a+x /etc/cron.daily/tarsnap-backup

CapsLock->Esc
-------------

Set `XKBOPTIONS="caps:escape"` in `/etc/default/keyboard`

```
udevadm trigger --subsystem-match=input --action=change
```

Lightdm
-------

Edit `/etc/lightdm/lightdm.conf`. Under `[Seat:*]` set:

* `greeter-hide-users=false`
* `xserver-command=X -ardelay 250 -arinterval 20`

Rust
----

curl https://sh.rustup.rs -sSfL | sh
rustup component add rustfmt-preview rust-analysis rust-src
cargo install cargo-fuzz cargo-deb

Crontab
-------

`0 */3 * * * DISPLAY=:0.0 ${HOME}/.local/bin/artsandculturedesktop > /tmp/artsandculturedesktop.log 2>&1`

Steam
-----

```
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install steam
```

Docker
------

```
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key --keyring /etc/apt/trusted.gpg.d/docker.gpg add -
sudo tee /etc/apt/sources.list.d/docker.list <<EOF
deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable
EOF
sudo apt update
sudo apt install docker
```

After running docker:

```
sudo usermod -aG docker julian
```

Node
----

```
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/nodesource.gpg add -
sudo tee /etc/apt/sources.list.d/nodesource.list <<EOF
deb https://deb.nodesource.com/node_16.x $(lsb_release -cs) main
deb-src https://deb.nodesource.com/node_16.x $(lsb_release -cs) main
EOF
sudo apt update
sudo apt install nodejs
npm install -g bash-language-server pyright typescript typescript-language-server vim-language-server yaml-language-server
```

KaTrain
-------

### Build KataGo

Install Dependencies from packages, then:

```
cd /tmp
git clone https://github.com/lightvector/KataGo.git
cd /KataGo/cpp
cmake . -DUSE_BACKEND=EIGEN -DUSE_TCMALLOC=1 -DUSE_AVX2=1 -DCMAKE_CXX_FLAGS='-march=native'
make
```

Find the built executable and move it to ~/.local/bin

### Install KaTrain

```
mkvirtualenv katrain
cd /tmp
git clone https://github.com/sanderland/katrain.git
cd katrain
pip install -r requirements.txt
pip install .
```

Launch KaTrain, and configure it to use the build KataGo executable

Misc Setup
----------

```
sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt
sudo update-alternatives --set x-www-browser /usr/bin/chromium
sudo usermod -a -G lpadmin julian
sudo usermod -a -G dialout julian
```

Download and install goban-screenhack, sgf-render, and markovpass
Download and install xsecurelock from github

TODO
----
Monitor hotplugging?
