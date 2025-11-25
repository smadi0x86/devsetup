set nocompatible
filetype plugin indent on
syntax on

set number
set relativenumber
set t_Co=256

colorscheme habamax

set clipboard=unnamedplus
set mouse=a
set hidden
set wrap
set scrolloff=8

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set ignorecase
set smartcase
set incsearch
set hlsearch

let mapleader = " "

autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>f gg=G
nnoremap <Leader>n :set relativenumber!<CR>
nnoremap <Leader>N :set number!<CR>
nnoremap <Leader>r :source $MYVIMRC<CR>
