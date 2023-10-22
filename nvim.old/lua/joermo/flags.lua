local g = vim.g
local o = vim.o

-- Global
g.mapleader = " "
g.signcolumn = true

-- Options
o.guicursor = ""
o.nu = true
o.relativenumber = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.wrap = false
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.nvim/undodir"
o.undofile = true
o.hlsearch = true
o.incsearch = true
o.termguicolors = true
o.scrolloff = 8
o.signcolumn = "yes:1"
o.updatetime = 50
o.colorcolumn = "80"
vim.opt.listchars = { tab = "▸ ", trail = "·" }
o.clipboard = "unnamedplus"
o.spell = false
o.cursorline = true
o.columnline = true
