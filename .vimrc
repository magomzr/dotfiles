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

" ***** Remaps *****
" turn off highlighting
nnoremap <leader><space> :noh<CR>
" to quickly go back to explorer
nnoremap <leader>e :Explore<CR>
" move by visual lines. works with wrap
nnoremap j gj
" move by visual lines. works with wrap
nnoremap k gk

" Terminal
nnoremap <leader>t :vsplit \| terminal<CR>

" Navigation
" move to left split
nnoremap <C-h> <C-w>h
" move to right split
nnoremap <C-l> <C-w>
" move to bottom split
nnoremap <C-j> <C-w>j
" move to top split
nnoremap <C-k> <C-w>k

" Move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Files
" save file
nnoremap <leader>w :w<CR>
" close window
nnoremap <leader>q :q<CR>

" LSP
" show error detail
nnoremap <leader>d :lua vim.diagnostic.open_float()<CR>
" go to definition
nnoremap gd :lua vim.lsp.buf.definition()<CR>
" rename symbol
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
" code actions
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>

" Formatter
" format file
nnoremap <leader>f :lua require('conform').format()<CR>

" Grepping
" quick grep
nnoremap <leader>g :grep<space>
" next result
nnoremap ]g :cnext<CR>
" previous result
nnoremap [g :cprev<CR>

" Jump to last cursor position when reopening a file
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Using ripgrep as the external command for grepping
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
