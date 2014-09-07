set nocompatible

" needed for vundle, will be turned on after vundle inits
filetype off

" setup vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" vundle configuration
" GitHub modules
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Valloric/ListToggle'
Plugin 'Valloric/python-indent'
Plugin 'Valloric/vim-indent-guides'
Plugin 'anyakichi/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'gmarik/vundle'
Plugin 'jgdavey/tslime.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
" vim-scripts
Plugin 'YankRing.vim'
Plugin 'gnupg.vim'
Plugin 'python.vim'
Plugin 'python_match.vim'
Plugin 'tex_autoclose.vim'

" end of vundle configuration
call vundle#end()

if executable('go')
    let goroot = system("go env GOROOT")
    let goroot = substitute(goroot, '\n$', '', '')
    execute "set rtp+=" . goroot . "/misc/vim"
endif

syntax on
set backspace=2     " allow backspacing over everything in insert mode
set laststatus=2    " always a status line
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set showmatch       " briefly jump to matching bracket
set wildmenu        " enhanced completion in command-line
set wildignore=*.o,*.pyc,*.swp    " ignore some files when completing
set autoindent      " always set autoindenting on
set copyindent      " copy the previous indentation on autoindenting
colorscheme jellybeans
set guifont=DejaVu\ Sans\ Mono\ 9
set guioptions-=m   " no menubar
set guioptions-=T   " no toolbar
set guioptions-=r   " no scrollbar
set hlsearch        " highlight search
set incsearch       " incremental search
set ignorecase      " case-smart searching
set smartcase       " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set hidden          " set hidden buffers (to switch buffer without saving it)
set shiftround 	    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab        " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set nobackup        " no backups
set directory=~/tmp/vim/swap   " swap files
set complete-=i     " do not scan included files for completion
set undofile        " save undo history
set undolevels=1000 " number of changes to keep
set undodir=~/tmp/vim/undo     " where to save undo files

" extended % matching
runtime macros/matchit.vim

" swap ' with `
nnoremap ' `
nnoremap ` '

let mapleader = ","
let maplocalleader = ","

map <C-Tab> :bnext<CR>
map <S-C-Tab> :bprevious<CR>

" toggle highlight search
nmap <silent> <leader>n :silent :nohlsearch<CR>

" show spaces
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" enable indent plugin
filetype plugin on
filetype plugin indent on

" map F7 to make, cn to :cnext and cp to :cprevious
nmap <silent> <F7> :make<CR>
nmap <silent> cn :cnext<CR>
nmap <silent> cp :cprevious<CR>

" switch to paste mode with F2
set pastetoggle=<F2>

" select latest visual selection
map <leader>v V`]

" CtrlP
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_dotfiles = 0
let g:ctrlp_working_path_mode = 0
nmap <silent> <leader>b :CtrlPBuffer<CR>

" tslime.vim
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 7

" YankRing
let g:yankring_history_dir = '~/tmp/vim'
" no single char in the yankring
let g:yankring_min_element_length = 2
let g:yankring_window_height = 14
nnoremap <leader>r :YRShow<CR>

" easymotion
nmap s <Plug>(easymotion-s)
