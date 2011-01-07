set nocompatible

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
set backspace=2     " allow backspacing over everything in insert mode
set laststatus=2    " always a status line
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set showmatch       " briefly jump to matching bracket
set wildmenu        " enhanced completion in command-line
set wildignore=*.o,*.pyc,*.swp    " ignore some files when completing
set autoindent      " always set autoindenting on
set copyindent      " copy the previous indentation on autoindenting
if has("gui_running")
    colorscheme sorcerer
else
    colorscheme torte
endif
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
set nobackup

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
match ErrorMsg '\%>80v.\+'

" enable indent plugin
filetype plugin on
filetype plugin indent on

" map F7 to make, cn to :cnext and cp to :cprevious
nmap <silent> <F7> :make<CR>
nmap <silent> cn :cnext<CR>
nmap <silent> cp :cprevious<CR>

" switch to paste mode with F2
set pastetoggle=<F2>

" Lusty Juggler
nmap <silent> <leader>b :LustyJuggler<CR>
