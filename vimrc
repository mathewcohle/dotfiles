" Leader
let mapleader = ","

syntax on         " swith syntax highlight on
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set noshowmode
set history=500
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set cursorline    " highlight current line
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set wildmenu      " visual autocomplete for command menu
set lazyredraw    " redraw only when we need to.
set showmatch     " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase
set smartcase
set mouse=a       " enable mouse for all modes
set clipboard+=unnamed
set number
set numberwidth=1
" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·
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
" Autocomplete with dictionary words when spell check is on
set complete+=kspell
" Always use vertical diffs
set diffopt+=vertical
" Define colorscheme
set termguicolors
set background=dark
colorscheme boa
highlight Comment cterm=bold

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
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile .jsons set filetype=json
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
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType sql              let b:comment_leader = '--'

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
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Custom map
map <F2> :Errors<CR>
map <F3> :NERDTreeTabsToggle<CR>
map <F4> :call TabmergeLast() <CR>
map <F5> :CtrlPClearCache<CR>
" Terminal-like beginning and end of line.
map <c-e> <c-o>$
map <c-a> <c-o>^
imap jj <Esc>l
nmap j gj
nmap k gk
" Split line
nnoremap K i<CR><Esc>
" Map backspace to delete letter in normal mode
nnoremap <bs> X
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" highlight last inserted text
nnoremap gV `[v`]
" change behaviour or e, move at the end of the word instead before the last
" letter
nnoremap e el
" turn off search highlight
nnoremap <Leader><space> :nohlsearch<CR>

noremap <Leader>q :quit<CR>
noremap <Leader>Q :quit!<CR>
noremap <Leader>s :update<CR>
noremap <Leader>n :bnext<CR>
noremap <Leader>N :bprev<CR>
noremap <Leader>f :Autoformat<CR>
noremap <Leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <Leader>G :YcmCompleter GoToDefinitionElseDeclaration<CR> <bar> :call TabmergeLast() <CR>
noremap <Leader>r :YcmCompleter GoToReferences<CR>
noremap <Leader>e :CtrlPMRUFiles <CR>
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
" Map keys to (un)comment
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Include packages
execute pathogen#infect()
execute pathogen#helptags()

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_auto_jump = 0
let g:syntastic_python_checkers = ['flake8', 'pep8', 'python']
let g:syntastic_python_flake8_args='--ignore=E501'

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'relativepath', 'modified' ] ]
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'component_function': {
      \   'gitbranch': 'LightlineFugitive',
      \ },
      \ }
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_goto_buffer_command = 'new-or-existing-tab' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_autoclose_preview_window_after_completion=1

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:nerdtree_tabs_open_on_console_startup = 0

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 'ET'
let g:ctrlp_working_path_mode = 'ra'
" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
" Note it works only if ctrlp_user_command is not set
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(pyc)$',
  \ }
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --hidden -g "" %s'
endif

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Custom functions
" Recors last tab number to variable
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()

function! TabmergeLast()
" Merge left tab to right tab and focus left window
    :execute 'Tabmerge ' . g:lasttab . ' right'
    :wincmd l
endfunction

" Custom command definitions
command! J :%!python -m json.tool
" Close when no buffer is opened
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
