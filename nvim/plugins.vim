" VIM-PLUG
" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.config/nvim/autoload/plugged')
" UNCOMMENT TO SOURCE ALL PLUGIN CONFIGS FROM plugins.vim
"source ~/.vim/plugins.vim
Plug 'https://github.com/preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'https://github.com/prabirshrestha/vim-lsp'
Plug 'https://github.com/dense-analysis/ale'
"Plug 'https://github.com/junegunn/fzf'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/ErichDonGubler/vim-sublime-monokai'
"Plug 'https://github.com/nvim-treesitter/nvim-treesitter'
Plug 'https://github.com/folke/which-key.nvim'
call plug#end()
