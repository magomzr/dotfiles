" Appearance
syntax on
set number                      " to show lines
set relativenumber              " relative line numbers, for jumping (5j, 12k)
set ruler                       " cursor position, bottom-right
set cursorline                  " highlights current line
set scrolloff=8                 " keep 8 context lines when scrolling
set showmatch                   " jump to matching bracket when typing
set title                       " show filename in window titlebar
set splitbelow                  " new horizontal split opens below, more natural
set splitright                  " new vertical split opens to the right, more natural

" Indentation
set autoindent                  " keep previous line indentation
set smartindent                 " smart indent by context
set expandtab                   " from tabs to spaces
set tabstop=2                   " tab = 2 spaces
set shiftwidth=2                " indent with >> on visual mode, 2 spaces as well

" Search
set hls                         " highlights searchs
set is                          " incremental searchs
set ignorecase                  " case insensitive searchs
set smartcase                   " case sensitive when searching in UPPERCASE
set wildmenu                    " autocomplete with tab in commands bar

" Usability
set nowrap                      " no line breaking on long lines
set laststatus=2                " always show status bar at the bottom
set backspace=indent,eol,start  " backspace like any other editor
set autoread                    " auto reload file if changed outside vim

" Configuration
set encoding=utf-8              " encoding
set hidden                      " allow to change files without saving first
set showcmd                     " show command build before executing
set matchpairs+=<:>             " extends showmatch behavior with <>

" Leader
let mapleader = " "             " space as leader key

" Remaps
nnoremap <leader><space> :noh<CR> " turn off highlighting
nnoremap <leader>e :Explore<CR>   " to quickly go back to explorer
" nnoremap j gj                   " move by visual lines. works with wrap
" nnoremap k gk                   " move by visual lines. works with wrap

" Terminal
nnoremap <leader>t :vsplit \| terminal<CR>

" Navigation
nnoremap <C-h> <C-w>h       " move to left split
nnoremap <C-l> <C-w>l       " move to right split
nnoremap <C-j> <C-w>j       " move to bottom split
nnoremap <C-k> <C-w>k       " move to top split

" Files
nnoremap <leader>w :w<CR>       " save file
nnoremap <leader>q :q<CR>       " close window

" LSP
nnoremap <leader>d :lua vim.diagnostic.open_float()<CR>  " show error detail
nnoremap gd :lua vim.lsp.buf.definition()<CR>            " go to definition
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>        " rename symbol
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>   " code actions

" Formatter
nnoremap <leader>f :lua require('conform').format()<CR>  " format file

" Jump to last cursor position when reopening a file
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
