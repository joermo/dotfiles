local g = vim.g
local o = vim.o

o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.relativenumber = true
o.nu = true
-- o.hidden = true
-- o.hidden = false -- todo re-enable this in case of any error
o.ignorecase = true
o.undodir = os.getenv("HOME") .. "/.nvim/undodir"
o.undofile = true
o.incsearch = true
o.scrolloff = 10
o.colorcolumn = "80"
o.cmdheight = 0 -- set to 0 to use lualine
o.updatetime = 50
o.wrap = false
o.background = "dark"
o.guicursor = ""
o.errorbells = false
o.smartindent = true
o.smartcase = true
o.signcolumn = "yes:1"
o.list = true
o.clipboard = "unnamedplus"
o.spell = false
o.cursorline = true
o.termguicolors = true
o.foldlevel = 99

g.signcolumn = true
g.noerrorbells = true
g.noswapfile = true
g.nvim_tree_respect_buf_cwd = 1
o.conceallevel = 0

-- test configs
g.lazygit_config = true
o.mouse = "a" -- Enable mouse mode
o.number = true -- Print line number
o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.listchars = { tab = "▸ ", trail = "·" }
vim.opt.timeoutlen = 1000

vim.cmd("set notermsync") -- only works by calling vim builtin; fixes cursor teleporting/flickering with zellij
