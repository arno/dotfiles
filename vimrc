syntax on
set nocompatible
set backspace=2
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set showmatch
set wildmenu
set wildignore=*.o,*.pyc
"set wildmode=list:longest
set autoindent
set smartindent
if has("gui_running")
    colorscheme wombat
else
    colorscheme torte
endif
set guifont=Inconsolata\ 9
" no menubar
set guioptions-=m
" no toolbar
set guioptions-=T
"set cursorline
" highlight search
set hlsearch
set incsearch
" case-smart searching
set ignorecase
set smartcase

set hidden

" extended % matching
runtime macros/matchit.vim

" swap ' with `
nnoremap ' `
nnoremap ` '

let mapleader = ","

" FuzzyFinder + FuzzyFinderTextMate
let g:fuzzy_ignore = "*.o,*.pyc"
let g:fuzzy_enumerating_limit = 70

map <C-Tab> :bnext<CR>
map <S-C-Tab> :bprevious<CR>
map <leader>t :FuzzyFinderTextMate<CR>
map <leader>b :FuzzyFinderBuffer<CR>

" NERDTree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" toggle highlight search
nmap <silent> <leader>n :silent :nohlsearch<CR>

" show spaces
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

