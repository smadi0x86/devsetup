" Minimal Vim Configuration for SSH Remote Machines
" Fast, lightweight, no plugins required

" Basic Settings
set nocompatible              " Disable vi compatibility
set encoding=utf-8            " UTF-8 encoding
set backspace=indent,eol,start " Allow backspace over everything

" Display
set number                    " Show line numbers
set relativenumber           " Relative line numbers
set ruler                    " Show cursor position
set showcmd                  " Show command in status line
set showmatch               " Highlight matching brackets
set laststatus=2            " Always show status line
set wildmenu                " Enhanced command completion
set wildmode=longest:full,full

" Search
set hlsearch                " Highlight search results
set incsearch              " Incremental search
set ignorecase             " Case insensitive search
set smartcase              " Case sensitive if uppercase present

" Indentation
set autoindent             " Auto indent
set smartindent            " Smart indent
set tabstop=4              " Tab width
set shiftwidth=4           " Indent width
set expandtab              " Use spaces instead of tabs
set smarttab               " Smart tab behavior

" Performance
set lazyredraw             " Don't redraw during macros
set ttyfast                " Fast terminal connection
set updatetime=300         " Faster completion

" Files
set autoread               " Auto reload changed files
set noswapfile            " Disable swap files
set nobackup              " Disable backup files
set undofile              " Persistent undo
set undodir=~/.vim/undo   " Undo directory

" Create undo directory if it doesn't exist
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p", 0700)
endif

" Visual
syntax on                  " Syntax highlighting
set background=dark        " Dark background
colorscheme default        " Use default colorscheme
set cursorline            " Highlight current line
set scrolloff=3           " Keep 3 lines visible when scrolling

" Key Mappings
let mapleader = " "        " Space as leader key

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :wq<CR>

" Clear search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" Better navigation
nnoremap j gj
nnoremap k gk
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick buffer switching
nnoremap <leader>b :buffers<CR>:buffer<Space>
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprev<CR>

" Quick file operations
nnoremap <leader>e :e<Space>
nnoremap <leader>v :vsplit<Space>
nnoremap <leader>s :split<Space>

" Copy/paste with system clipboard
if has('clipboard')
    set clipboard=unnamedplus
    nnoremap <leader>y "+y
    nnoremap <leader>p "+p
endif

" Quick editing of common files
nnoremap <leader>rc :e ~/.vimrc<CR>
nnoremap <leader>bp :e ~/.bashrc<CR>

" Toggle line numbers
nnoremap <leader>l :set number!<CR>

" Quick indentation
vnoremap < <gv
vnoremap > >gv

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" File type specific settings
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType css setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType json setlocal tabstop=2 shiftwidth=2 expandtab

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Status line
set statusline=%f                           " File name
set statusline+=%m                          " Modified flag
set statusline+=%r                          " Read-only flag
set statusline+=%=                          " Right align
set statusline+=%l/%L                       " Line/Total lines
set statusline+=\ %c                        " Column
set statusline+=\ %p%%                      " Percentage through file
