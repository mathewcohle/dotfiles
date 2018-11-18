" Leader
let mapleader = ","

syntax on         " swith syntax highlight on
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
set tabstop=2
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
set clipboard=unnamedplus
" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·
" Use one space, not two, after punctuation.
set nojoinspaces
" Make it obvious where 79 characters is
set textwidth=79
set colorcolumn=+1
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add
set encoding=utf-8
" Autocomplete with dictionary words when spell check is on
set complete+=kspell
" Always use vertical diffs
set diffopt+=vertical
" Get rid of '|' in vertical split and weird color
" Define colorscheme
let g:gruvbox_italic=1
colorscheme gruvbox
set termguicolors
" Disable folding
set nofoldenable
" Enable auto indent
set autoindent
set smartindent

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
" " Auto reload vimrc
" autocmd bufwritepost .vimrc source ~/.vimrc
" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType rust             let b:comment_leader = '// '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType sql              let b:comment_leader = '--'
autocmd FileType yaml             let b:comment_leader = '# '
autocmd FileType dockerfile       let b:comment_leader = '# '
autocmd FileType neomuttrc        let b:comment_leader = '# '
" Shortcut to open buffer in vsplit from quickfix windov
autocmd! FileType qf nnoremap <buffer> <C-v> <C-w><Enter><C-w>L
" Automatically update copyright notice with current year
autocmd BufWritePre *
  \ if &modified |
  \   exe "g#\\cCopyright (C) \\(".strftime("%Y")."\\)\\@![0-9]\\{4\\}\\(-".strftime("%Y")."\\)\\@!#s#\\([0-9]\\{4\\}\\)\\(-[0-9]\\{4\\}\\)\\?#\\1-".strftime("%Y") |
  \ endif

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <S-Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <Tab> <c-n>

nmap j gj
nmap k gk
" Custom map
nnoremap <F3> :NERDTreeToggle<CR>
" Split line
nnoremap K i<CR><Esc>
nnoremap \ :Ag<CR>
" Map backspace to delete letter in normal mode
nnoremap <bs> X
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <Leader><Space> :nohlsearch<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>Q :quit!<CR>
nnoremap <Leader>s :update<CR>
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>N :bprev<CR>
nnoremap <Leader>d :YcmCompleter GetDoc<CR>
nnoremap <Leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <Leader>G :vsp <CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>
nnoremap <Leader>r :YcmCompleter GoToReferences<CR>
nnoremap <Leader>i :Git<space>
nnoremap <Leader>fl :Gblame<CR>
nnoremap <Leader>fc :Commits<CR>
nnoremap <Leader>fb :BCommits<CR>
nnoremap <Leader>fs :Gstatus<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <Leader>e <Esc>:w<CR>:!clear;python %<CR>
nnoremap <Leader>t <Esc>:w<CR>:!clear;nosetests --logging-level=INFO -vs %<CR>
" Map keys to (un)comment
noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
" Convient way to copy path to current buffer
noremap <Leader>cf :let @+=expand("%")<CR>
" Map keys for movement in command line
:cnoremap <C-h> <Right>
:cnoremap <C-l> <Left>
:cnoremap <C-j> <Down>
:cnoremap <C-k> <Up>

" Include packages
execute pathogen#infect()
execute pathogen#helptags()

" Ale settings
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_set_quickfix = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['autopep8', 'flake8']}
let g:ale_fixers = {'python': [
      \ 'autopep8',
      \ 'isort',
      \ 'remove_trailing_lines',
      \ 'trim_whitespace' ]
      \}

" Lightline setttings
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

" YcmCompleter settings
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:nerdtree_tabs_open_on_console_startup = 0

" FZF settings
let $FZF_DEFAULT_COMMAND = 'ag -Q -l --hidden -g ""'
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Files command with preview window
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" Augmenting Ag command using fzf#vim#with_preview function
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:30%'),
  \                 <bang>0)
" table-mode settings
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

" isort settings
let g:vim_isort_python_version = 'python3'

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Custom command definitions
command! Json :%!python -m json.tool
" Close when no buffer is opened
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
