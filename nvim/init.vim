syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set relativenumber
set nu
set hidden
set noerrorbells
set nowrap
set noswapfile
set ignorecase
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=10
set colorcolumn=80
set signcolumn=yes
set cmdheight=2
set updatetime=50
set shortmess+=c

call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'https://github.com/preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'https://github.com/prabirshrestha/vim-lsp'
Plug 'https://github.com/dense-analysis/ale'
Plug 'https://github.com/junegunn/fzf'
Plug 'https://github.com/ErichDonGubler/vim-sublime-monokai'
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
call plug#end()

colorscheme sublimemonokai
inoremap kj <Esc>

" BEGIN COC CONFIG
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
