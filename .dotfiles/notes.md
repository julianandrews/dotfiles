# Dotfiles

Two repo dotfiles.

All shared config tracked in the main dotfiles repo. Computer specific config
tracked in the dotfiles-local repo.

## Dotfiles Setup

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

## Basic Config

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
sudo usermod -a -G render $USER
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

# Typescript
npm install -g @vtsls/language-server

# Bash
npm install -g bash-language-server

# yaml
npm install -g yaml-language-server

# Docker
sudo usermod -aG docker $USER
npm install -g dockerfile-language-server-nodejs

# Twine
uv tool install twine --with keyring --with keyring-pass

# R
Rscript -e "dir.create(Sys.getenv('R_LIBS_USER'), recursive = TRUE, showWarnings = FALSE);"
Rscript -e "install.packages('languageserver')"
Rscript -e "install.packages('renv')"

# Opencode
npm install -g opencode-ai
```

## Syncthing

```
sudo systemctl enable --now syncthing@julian.service
```

## Steam

Run the installer:

```
steam
```

## Chrome

- Install PWAs
    - https://calendar.google.com
    - https://messages.google.com
    - https://jellyfin.seemyvest.net
    - https://youtube.com
    - https://chat.deepseek.com
- Allow GMail to handle email addresses
- Allow Google Calendar to handle "web calendar links"

## Mail (isync/mbsync)

Install goimapnotify to ~/.local/bin (TODO: Make a debian package for this thing)

```
mkdir -p ~/.local/share/mail/fastmail ~/.config/credstore
pass show personal/fastmail/app-password | systemd-creds encrypt --user --name=fastmail-app-password - ~/.config/credstore/fastmail-app-password.cred
pass show personal/google/calendar-sync/client-secret | systemd-creds encrypt --user --name=calendar-sync-client-secret - ~/.config/credstore/calendar-sync-client-secret.cred
pass show diana/google/ical-address | systemd-creds encrypt --user --name=calendar-sync-diana-ical-address - ~/.config/credstore/calendar-sync-diana-ical-address.cred
systemctl --user enable --now mbsync.timer
systemctl --user enable --now notmuch.timer
systemctl --user enable --now maildir-archive.timer
systemctl --user enable --now goimapnotify.service
systemctl --user enable --now vdirsyncer.timer
```

## Debian packaging (sbuild)

```
sudo adduser $USER sbuild
update-sbuild-chroots
systemctl --user enable --now update-sbuild-chroots.timer 
```
