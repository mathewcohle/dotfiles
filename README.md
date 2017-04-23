# dotfiles

Collection of dotfiles to make setup of new machine easier

## Usage

Most of the work can be done just by downloading the repo and either moving it
to `$HOME` dir or even better create symbolic link from `$HOME` dir to files in
this repo. In that case files can be synced just by pulling new versions.

## Setup

Run following commands to setup the packages
```
# Create symbolic links in $HOME
cd ~
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/vim .vim
ln -s dotfiles/bashrc .bashrc
ln -s dotfiles/gitconfig .gitconfig
ln -s dotfiles/tmux.conf .tmux.conf

# Install vim packages
cd dotfiles/vim/bundle
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/vim-airline/vim-airline 
git clone https://github.com/vim-airline/vim-airline-themes 
git clone https://github.com/Chiel92/vim-autoformat.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/Valloric/YouCompleteMe.git
git clone https://github.com/ctrlpvim/ctrlp.vim.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/jistr/vim-nerdtree-tabs.git
```

Compile [YouCompleteMe](http://valloric.github.io/YouCompleteMe/#installation)
```
cd YouCompleteMe/
sudo apt-get install build-essential cmake
sudo apt-get install python-dev python3-dev
git submodule update --init --recursive
./install.py --clang-completer
```
To have Python3 Sematic Completion, please update `ycm_python_binary_path` in
`.vimrc`:
```
let g:ycm_python_binary_path = '/usr/bin/python3'
```
In case you are using `virtualenv` use:

```
let g:ycm_python_binary_path = 'python'
```

## Git setup

Configure global `gitignore` (given repo is cloned to `$HOME`):
```
git config --global core.excludesfile ~/dotfiles/gitignore_global
```

## Other dependencies

* `pip install --upgrade autopep8`
