DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
mkdir -p ~/.config/xfce4/terminal
ln -s "$DIR/.config/i3" ~/.config/
ln -s "$DIR/.config/i3status" ~/.config/
ln -s "$DIR/.config/xfce4/terminal/terminalrc" ~/.config/xfce4/terminal/terminalrc

ln -s "$DIR/.virtualenvs/postactivate" ~/.virtualenvs/
ln -s "$DIR/bin" ~/
ln -s "$DIR/.bashrc" ~/
ln -s "$DIR/.vimrc" ~/
ln -s "$DIR/.vim" ~/
