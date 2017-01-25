# dotfiles

Collection of dotfiles to make setup of new machine easier

## Usage

Most of the work can be done just by downloading the repo and either moving it
to `$HOME` dir or even better create symbolic link from `$HOME` dir to files in
this repo. In that case files can be synced just by pulling new versions.

## Common problems

Usually it is necessary to download separately
[Synsastic](https://github.com/vim-syntastic/syntastic)
```
cd ~/.vim/bundle
rm -rf syntastic
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
```
Also it might be necessary to recompile
[YouCompleteMe](http://valloric.github.io/YouCompleteMe/#installation)
```
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```
To have Python Sematic Completion, please update `ycm_python_binary_path` in
`.vimrc`:
```
let g:ycm_python_binary_path = '/usr/bin/python3'
```

## Other dependencies

* `pip install --upgrade autopep8`
