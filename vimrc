" Include packages
"  083cbee6094c9ec347d7c75af421be27d2ec7e70 vim/bundle/vim-grammarous (heads/master)
call plug#begin("~/.vim/plugged")
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'rhysd/vim-grammarous'
Plug 'tpope/vim-fugitive'
call plug#end()

" Leader
let mapleader = ","

syntax on         " switch syntax highlight on
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set noshowmode
set history=500
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set cursorline    " highlight current line
set tabstop=4
set shiftwidth=4  " http://vimdoc.sourceforge.net/htmldoc/options.html#'shiftwidth'
set softtabstop=4
set shiftround
set expandtab
set wildmenu      " visual autocomplete for command menu
set lazyredraw    " redraw only when we need to.
set showmatch     " highlight matching [{()}]
set incsearch     " search as characters are entered
set hlsearch      " highlight matches
set ignorecase
set smartcase
set mouse=a       " enable mouse for all modes
"set clipboard=unnamedplus
set clipboard+=unnamedplus
" Use one space, not two, after punctuation.
set nojoinspaces
" Make it obvious where 79 characters is
"set textwidth=79
set colorcolumn=80
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
set encoding=utf-8
" Always use vertical diffs
set diffopt+=vertical
set termguicolors
" Disable folding
set nofoldenable
" Enable auto indent
set autoindent
set smartindent
" Spell check configuration
set spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellRare
hi SpellRare cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline
set complete+=kspell
" Define color scheme; this needs to be defined after spell highlighting
let g:gruvbox_italic=1
colorscheme gruvbox

filetype plugin indent on

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END
" setup for use with neomutt
augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *neomutt-*              setfiletype mail
augroup END
" Auto strip trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
" Set textwidth for all files, wrap visual selection with gq
auto BufRead,BufNewFile setlocal textwidth=79
" Shortcut to open buffer in vsplit from quickfix window
autocmd! FileType qf nnoremap <buffer> <C-v> <C-w><Enter><C-w>L

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"

nmap j gj
nmap k gk
" Split line
nnoremap K i<CR><Esc>
nnoremap \ :Rg<CR>
" Map backspace to delete letter in normal mode
nnoremap <bs> X
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Map keys for movement in command line
:cnoremap <C-h> <Right>
:cnoremap <C-l> <Left>
:cnoremap <C-j> <Down>
:cnoremap <C-k> <Up>

" Language agnostic mappings
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <Leader><Space> :nohlsearch<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>Q :quit!<CR>
nnoremap <Leader>w :update<CR>
nnoremap <Leader>fc :Commits<CR>
nnoremap <Leader>fb :BCommits<CR>
nnoremap <Leader>fs :Git<CR>
nnoremap <Leader>fl :Git log --graph --format="%h%d %s <%an>" --abbrev-commit --date=relative<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <leader>fg :call fzf#vim#tags('^' . expand('<cword>'), {'options': '--exact --select-1 --exit-0 +i'})<CR>
nnoremap <Leader>tf :NERDTreeFind<CR>
nnoremap <Leader>tt :NERDTreeToggle<CR>
" Convenient way to copy path to current buffer
noremap <Leader>tc :let @+=expand("%")<CR>

" Lightline settings
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'relativepath', 'modified' ] ],
      \   'right': [['lineinfo'],
      \             ['percent'],
      \             ['fileformat', 'fileencoding', 'filetype', 'charvaluehex']]
      \ },
      \ 'inactive': {
      \   'left': [['mode', 'paste'],
      \            ['relativepath', 'modified']],
      \   'right': []
      \ },
      \ 'component_function': {
      \   'gitbranch': 'LightlineFugitive',
      \ },
      \ }

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:nerdtree_tabs_open_on_console_startup = 0

" FZF settings
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --all --abbrev-commit --date=relative --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr %Cblue<%an>%Creset"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Custom command definitions
command! Json :%!python -m json.tool
" Close when no buffer is opened
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
