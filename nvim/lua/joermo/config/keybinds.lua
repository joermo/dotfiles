vim.g.mapleader = " "
local bind = vim.keymap.set

-- Default
bind("i", "kj", "<Esc>")
bind("i", "jk", "<Esc>")
bind("n", "<Leader>n", "<CMD>noh<CR>")

-- Windows
bind("n", "<Leader>wl", "<C-W>l")
bind("n", "<Leader>wh", "<C-W>h")
bind("n", "<Leader>wk", "<C-W>k")
bind("n", "<Leader>wj", "<C-W>j")
bind("n", "<Leader>wv", "<CMD>vsplit<CR>")
bind("n", "<Leader>ws", "<CMD>split<CR>")

-- Buffers
bind({ "n" }, "H", "<CMD>bprevious<CR>")
bind({ "n" }, "L", "<CMD>bnext<CR>")
bind({ "n" }, "<leader>q", "<CMD>%bd|e#<CR>")

-- NvimTree
bind("n", "<C-n>", "<CMD>NvimTreeToggle<CR>")
bind("n", "tf", "<CMD>NvimTreeFindFile<CR>")

-- Terminal
bind({ "n", "v", "i", "t" }, "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>")
bind({ "n", "v", "i", "t" }, "<A-o>", "<CMD>stopinsert<CR>")
bind({ "t", "v", "i", "t" }, "<Esc>", "<C-\\><C-n>")
-- bind({ "t", "i", "t" }, "kj", "<C-\\><C-n>")
bind({ "i" }, "kj", "<C-\\><C-n>")

-- Trouble
bind("n", "<Leader>t", "<CMD>TroubleToggle<CR>")
bind("n", "qf", "<CMD>TroubleToggle quickfix<CR>")

-- Misc
bind("v", "<leader>j", "J")
bind("v", "J", ":m '>+1<CR>gv=gv")
bind("v", "K", ":m '<-2<CR>gv=gv")
bind("x", "<leader>p", '"_dP')
bind("n", "J", "mzJ`z")
bind("n", "<C-d>", "<C-d>zz")
bind("n", "<C-u>", "<C-u>zz")
bind("n", "n", "nzzzv")
bind("n", "N", "Nzzzv")

-- TODO possibly extract all keybinds from LSP to here; commenting out for now

-- LSP
-- bind("n", "gd", function()
--   require("telescope.builtin").lsp_definitions({ reuse_win = true })
-- end)
bind("n", "gi", function()
  require("telescope.builtin").lsp_implementations({ reuse_win = true })
end)
-- bind("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
bind("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
bind({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
bind("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
bind("n", "gK", vim.lsp.buf.signature_help)
bind("n", "<leader>cA", function()
  vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
end)

-- Formatting
local conform_format = require("joermo.plugins.formatting").joermo_format_utils.conform_format
local format_range_operator = require("joermo.plugins.formatting").joermo_format_utils.format_range_operator
vim.keymap.set({ "v" }, "<leader>fc", conform_format, { desc = "Format Selection" })
vim.keymap.set({ "n" }, "<leader>F", conform_format, { desc = "Format Buffer" })
vim.keymap.set({ "n" }, "gf", format_range_operator, { desc = "Format Motion" })

-- Lazygit
bind("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Open lazy git" })


-- Oil
bind("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


-- Refactoring
bind({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })


-- Inlay Hints
if vim.lsp.inlay_hint then
  bind("n", "<leader>h", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  end, { desc = "Toggle Inlay Hints" })
end

