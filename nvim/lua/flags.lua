local g = vim.g
local o = vim.o

g.mapleader = ' '

o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.relativenumber = true
o.nu = true
o.hidden = true
o.ignorecase = true
o.undodir = os.getenv('HOME') .. '/.nvim/undodir'
o.undofile = true
o.incsearch = true
o.scrolloff = 10
o.colorcolumn = 80
o.cmdheight = 2
o.updatetime = 50
o.wrap = false
o.background='dark'
o.guicursor = ""
o.errorbells = false
o.smartindent = true

g.signcolumn = true
g.noerrorbells = true
g.noswapfile = true
