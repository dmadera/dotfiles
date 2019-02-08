set nocompatible

" Pathogen win package manager
execute pathogen#infect()

"colorscheme solarized
set directory^=$HOME/.vim/tmp//
filetype on
filetype plugin on
filetype indent on
syntax on

set background=dark
"set cursorline
"set colorcolumn=80
set number
set clipboard=unnamed
set history=500
set wildmode=longest,list
set scrolloff=8

" shortcuts
let mapleader=" "
map <leader>e :e ++enc=cp1250<CR>
map <leader>i :normal gg=G``zz<CR>

" indenting
set wrap
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" settings to specific filetype
autocmd FileType html,javascript,jsx setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=4 tabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" able to write to sysstem file with sudo password
cmap w!! %!sudo tee > /dev/null %

" remove whitepaces on save
autocmd BufWritePre * :%s/\s\+$//e

" plugin Lightline fix
set laststatus=2
let g:lightline={ 'colorscheme': 'solarized' }
