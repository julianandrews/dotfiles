# Dotfiles

Two repo dotfiles.

All shared config tracked in the main dotfiles repo. Computer specific config
tracked in the dotfiles-local repo.

## Setup

```
sudo apt install git
mkdir "$HOME/.dotfiles"
git clone --bare https://github.com/julianandrews/dotfiles.git $HOME/.dotfiles/shared
git clone --bare https://github.com/julianandrews/dotfiles-local.git $HOME/.dotfiles/local
alias dotfiles='git --git-dir="$HOME/.dotfiles/shared" --work-tree="$HOME"'
alias dotfiles-local='git --git-dir="$HOME/.dotfiles/local" --work-tree="$HOME"'
dotfiles config --local status.showUntrackedFiles no
dotfiles-local config --local status.showUntrackedFiles no
dotfiles remote set-url origin git@github.com:julianandrews/dotfiles.git
dotfiles-local remote set-url origin git@github.com:julianandrews/dotfiles-local.git
dotfiles checkout
dotfiles-local checkout desktop
```

## Manual Steps

```
# Install packages
# First, manually add contrib and non-free to the debian sources
sudo cp ~/.dotfiles/apt/keyrings/* /etc/apt/keyrings/
sudo cp ~/.dotfiles/apt/sources.list.d/* /etc/apt/sources.list.d/
sudo cp ~/.dotfiles/apt/preferences.d/* /etc/apt/preferences.d/
sudo dpkg --add-architecture i386 # for steam-installer
sudo apt update
sudo apt install $(cat ~/.dotfiles/packages/packages{,.local,.contrib,.non-free})

# Configure sudoers
sudo usermod -a -G render julian
echo "Defaults !admin_flag" | sudo tee /etc/sudoers.d/no-admin-flag
sudo chmod 0440 /etc/sudoers.d/no-admin-flag

# Make history directories
mkdir ~/.local/share/{bash,python}

# Install Fonts
mkdir -p ~/.local/share/fonts
curl -L "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/DejaVuSansMono.tar.xz" \
    | tar -C ~/.local/share/fonts -xJ --wildcards '*.ttf'
curl -L -o /tmp/fontawesome.zip https://use.fontawesome.com/releases/v7.2.0/fontawesome-free-7.2.0-desktop.zip
unzip -j /tmp/fontawesome.zip -d ~/.local/share/fonts '*/otfs/*'
rm /tmp/fontawesome.zip
fc-cache -fv


# Steam (run the installer)
steam
```

## Dev setup

```
# Rust
rustup default stable
cargo install cargo-deb cargo-fuzz

# Python
cargo install uv
uv tool install basedpyright
uv tool install ruff

# Node
cargo install fnm
fnm install --lts
fnm default lts-latest
npm install -g pnpm

# Bash
npm install -g bash-language-server

# yaml
npm install -g yaml-language-server
```

## Yubico Authenticator

Download from https://github.com/Yubico/yubioath-flutter

```
sudo apt install $(cat ~/.dotfiles/packages/packages.yubico)`
```
