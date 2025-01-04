local g = vim.g
local o = vim.opt

-- Globals
g.mapleader = " "
g.maplocalleader = " "
g.have_nerd_font = true
g.noerrorbells = true
g.noswapfile = true

o.mouse = "a" -- enable mouse mode
o.showmode = false
vim.schedule(function() -- Schedule this  to not delay startup time
  o.clipboard = "unnamedplus"
end)
o.breakindent = true
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.nvim/undodir"
o.ignorecase = true
o.smartcase = true
o.signcolumn = "yes"
o.updatetime = 250
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.list = true
o.inccommand = "split"
o.cursorline = true
o.scrolloff = 10
o.cmdheight = 0 -- set to 0 to use lualine
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.guicursor = "" -- use block cursor
o.number = true
o.relativenumber = true
o.wrap = false
o.linebreak = true -- wrap lines at work boundaries

o.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- o.pumblend = 10 -- Popup blend
-- o.pumheight = 10 -- Maximum number of entries in a popup
-- vim.cmd("set notermsync") -- only works by calling vim builtin; fixes cursor teleporting/flickering with zellij
-- o.signcolumn = "yes:1"
-- o.conceallevel = 0
