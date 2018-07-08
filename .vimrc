set nocompatible

"Pathogen win package manager
execute pathogen#infect()

set directory^=$HOME/.vim/tmp//
filetype on
syntax on
set background=dark
colorscheme solarized
set cursorline
set colorcolumn=80
set number
set clipboard=unnamedplus
set history=100

"shortcuts
let mapleader=" "
map <leader>e :e ++enc=cp1250<CR>
map <leader>i :normal gg=G``zz<CR>
map <leader>d :NERDTreeToggle<CR>
map <leader>f :NERDTreeFocus<CR>

"indenting
filetype indent on
set wrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
autocmd FileType html,javascript,jsx setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=4 tabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

"able to write to sysstem file with sudo password
cmap w!! %!sudo tee > /dev/null %

"remove whitepaces on save
autocmd BufWritePre * :%s/\s\+$//e

"open NERDTree automaticaly if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"plugin Lightline fix
set laststatus=2
let g:lightline={ 'colorscheme': 'solarized' }
set noshowmode
let g:powerline_pycmd='python3'
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup

"plugin command-t ignore files
set wildignore+=*.cache,*.swp,node_modules,*.png,*.jpg,*.svg,*.map,assets,*.bak
let g:CommandTTraverseSCM='pwd'

"plugin NerdCommenter
filetype plugin on

"plugin vim-jsx
let g:jsx_ext_required=0 " Allow JSX in normal JS files
let g:javascript_plugin_flow=1

"plugin vim-closetag
let g:closetag_filenames='*.html,*.xhtml,*.phtml,*.jsx'
let g:closetag_xhtml_filenames='*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive=1
let g:closetag_shortcut='<leader>>'
let g:closetag_close_shortcut='>'
