KaTrain
-------

### Build KataGo

```
sudo apt install $(cat ~/.dotfiles/package-lists/katrain)
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
pip install katrain
ln -s /home/julian/.virtualenvs/katrain/bin/katrain ~/.local/bin/katrain
```

Launch KaTrain, and configure it to use the built KataGo executable
