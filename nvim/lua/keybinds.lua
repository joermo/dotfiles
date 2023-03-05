vim.g.mapleader = " "
local bind = vim.keymap.set

-- Default
bind('i','kj','<Esc>')
bind('i','kj','<Esc>')
bind('n','<Leader>n','<CMD>noh<CR>')
-- Windows
bind('n','<Leader>wl','<C-W>l')
bind('n','<Leader>wh','<C-W>h')
bind('n','<Leader>wk','<C-W>k')
bind('n','<Leader>wj','<C-W>j')
-- NvimTree
bind('n', '<C-n>', '<CMD>NvimTreeToggle<CR>')
bind('n', 'tf', '<CMD>NvimTreeFindFile<CR>')
-- Terminal
bind('n', '<A-i>', '<CMD>FloatermToggle<CR>')
bind({'n','v','i'}, '<A-o>', '<CMD>stopinsert<CR>')
