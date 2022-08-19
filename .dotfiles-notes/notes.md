# System Setup

## Dotfiles

Use the https url since on a new machine I won't yet have ssh keys in place.

```
sudo apt-get install git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/julianandrews/dotfiles.git $HOME/.dotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles remote set-url origin git@github.com:julianandrews/dotfiles.git
dotfiles checkout
```

It will probably be necessary to remove existing files (after possibly backing
them up), and then rerun `dotfiles checkout`.

## Configure repos and install packages

Double check package-lists/hardware-specific before installing.

```
sudo apt install $(cat ~/.dotfiles-notes/package-lists/apt)
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo cp ~/.dotfiles-nodes/keyrings/* /usr/share/keyrings/
sudo cp ~/.dotfiles-nodes/sources.list.d/* /etc/apt/sources.list.d/
sudo apt install $(cat ~/.dotfiles-notes/package-lists/hardware-specific)
sudo apt install $(cat ~/.dotfiles-notes/package-lists/base)
sudo apt install $(cat ~/.dotfiles-notes/package-lists/dev)
sudo apt install $(cat ~/.dotfiles-notes/package-lists/gui)
sudo dpkg --add-architecture i386
sudo apt install steam
```

## Neovim

```
sudo mkdir /opt/bin
curl -sSL https://github.com/neovim/neovim/releases/latest/download/nvim.appimage | sudo tee /opt/bin/nvim >/dev/null
sudo chmod a+x /opt/bin/nvim
sudo update-alternatives --install /usr/bin/editor editor /opt/bin/nvim 0
```

## CapsLock->Esc

Set `XKBOPTIONS="caps:escape"` in `/etc/default/keyboard`

```
sudo udevadm trigger --subsystem-match=input --action=change
```

## Lightdm

Edit `/etc/lightdm/lightdm.conf`. Under `[Seat:*]` set:

* `greeter-hide-users=false`
* `xserver-command=X -ardelay 250 -arinterval 20`

## Python and npm packages

```
curl -sSL https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && python3 /tmp/get-pip.py --user
python3 -m pip install --user black pillow pygments pylint pyxdg requests six \
    virtualenv virtualenvwrapper python-language-server
npm install -g bash-language-server pyright typescript \
    typescript-language-server vim-language-server yaml-language-server pnpm
```

## fzf

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Install local binaries

```
curl -sSL https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz | tar xzf - -C ~/.local/bin/
curl -sSL https://github.com/julianandrews/gmailcount/releases/latest/download/gmailcount.tar.gz | tar -xzf - -C ~/.local/bin/
curl -sSL https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer && chmod +x ~/.local/bin/rust-analyzer
curl -sSL https://github.com/julianandrews/selenite-lamp/releases/latest/download/selenite-lamp -o ~/.local/bin/selenite-lamp && chmod +x ~/.local/bin/selenite-lamp
curl -sSL https://github.com/julianandrews/markovpass/releases/latest/download/markovpass-linux.tar.gz | tar -xzf - -C ~/.local/bin/ markovpass
curl -sSL https://github.com/julianandrews/sgf-render/releases/latest/download/sgf-render-linux.tar.gz | tar -xzf - -C ~/.local/bin/ sgf-render
curl -sSL "https://get.helm.sh/helm-$(curl -Ls https://api.github.com/repos/helm/helm/releases/latest | jq -r .tag_name)-linux-amd64.tar.gz" | tar --strip-components 1 -xzf - -C ~/.local/bin linux-amd64/helm
curl -sSL "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o ~/.local/bin/kubectl && chmod a+x ~/.local/bin/kubectl
```

## Tarsnap

sudo -e /etc/cron.daily/tarsnap-backup

    #!/usr/bin/env sh
    su julian -c /home/julian/.local/bin/tarsnap-backup

sudo chmod a+x /etc/cron.daily/tarsnap-backup

## Rust

```
curl -sSfL https://sh.rustup.rs | sh
rustup component add rustfmt-preview rust-analysis rust-src
cargo install cargo-fuzz cargo-deb
```

## AWS

```
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install -i ~/.local/lib/aws-cli -b ~/.local/bin
```

## Install from .deb files

- chrome
- bat
- zoom
- goban-screenhack

## Misc Setup

```
sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt
sudo update-alternatives --set x-www-browser /usr/bin/brave-browser-stable
sudo update-alternatives --set editor /opt/bin/nvim

sudo usermod -a -G lpadmin julian
sudo usermod -a -G dialout julian

# after running docker
sudo groupadd docker
sudo usermod -aG docker julian

# Selenite Lamp
sudo tee /etc/udev/rules.d/99-selenite-lamp.rules <<EOF
SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", SYMLINK+="selenite-lamp", TAG+="systemd" RUN+="/bin/stty -F /dev/selenite-lamp -hupcl"
EOF

systemctl --user daemon-reload
systemctl --user enable --now desktop-bg.timer gmailcount.timer kupfer.service selenite.timer site-status.timer screenlock.service

# Have an app password ready
gmailcount jandrews271@gmail.com set-password
```
