set nocompatible

" needed for vundle, will be turned on after vundle inits
filetype off

" setup vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" vundle configuration
" GitHub modules
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Valloric/ListToggle'
Bundle 'Valloric/python-indent'
Bundle 'Valloric/vim-indent-guides'
Bundle 'anyakichi/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'gmarik/vundle'
Bundle 'jgdavey/tslime.vim'
Bundle 'jnwhiteh/vim-golang'
Bundle 'kien/ctrlp.vim'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'mileszs/ack.vim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tomasr/molokai'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
" vim-scripts
Bundle 'python.vim'
Bundle 'python_match.vim'
Bundle 'tex_autoclose.vim'

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
set guifont=Ubuntu\ Mono\ 11
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

" match lines exceeding 80 columns
"match ErrorMsg '\%>80v.\+'

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

" syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" use ag instead of ack if available
if executable('ag')
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" vim-session
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_directory = '~/tmp/vim/sessions'
