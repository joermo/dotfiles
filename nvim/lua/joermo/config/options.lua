local g = vim.g
local o = vim.o

o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.relativenumber = true
o.nu = true
o.hidden = true
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
vim.opt.listchars = { tab = "▸ ", trail = "·" }
o.clipboard = "unnamedplus"
o.spell = false
o.cursorline = true
o.columnline = true
o.termguicolors = true

g.signcolumn = true
g.noerrorbells = true
g.noswapfile = true
g.nvim_tree_respect_buf_cwd = 1
o.conceallevel = 0

-- Function to highlight yanked text with default visual highlight color
function OnYank()
  local default_highlight = vim.fn.synIDattr(vim.fn.hlID("Visual"), "bg")
  vim.highlight.on_yank({
    higroup = "Visual",
    timeout = 100,
    on_visual = true,
    hl_default = default_highlight,
  })
end

-- Enable highlighting of yanked text
vim.cmd([[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * lua OnYank()
    augroup END
]])


