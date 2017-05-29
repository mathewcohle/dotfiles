#!/bin/bash -e

echo 'Setting your system to be awesome.'

# Check prerequisities
if ! [ -x "$(command -v cmake)" ]; then
  echo 'Please install `cmake` before running setup.' >&2
  exit 1
fi

if [[ -f .aliases || -f .bashrc || -f .gitconfig || -f .tmux || -f tmux.conf ||
  -f .vim || -f .vimrc || -f .zshrc ]]; then
  echo 'Some dotfile already exists, not making any smart move automatically.'
  echo 'Either remove these dotfiles or edit this script manually.'
  exit 1
fi


# Create symbolic links in $HOME
cd ~
ln -s dotfiles/aliases .aliases
ln -s dotfiles/bashrc .bashrc
ln -s dotfiles/gitconfig .gitconfig
ln -s dotfiles/tmux .tmux
ln -s dotfiles/tmux.conf .tmux.conf
ln -s dotfiles/vim .vim
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/zshrc .zshrc

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

# Setup Ycm
cd YouCompleteMe/
git submodule update --init --recursive
./install.py --clang-completer

# Setup git
git config --global core.excludesfile ~/dotfiles/gitignore_global

# Setup other dependencies
sudo pip install --upgrade autopep8

if ! [ -x "$(command -v ag)" ]; then
  echo 'Install https://github.com/ggreer/the_silver_searcher' >&2
  exit 1
fi
