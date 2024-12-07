vim.g.mapleader = " "
local bind = vim.keymap.set
local utils = require("joermo.config.utils")

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
bind("n", "<leader>Q", function()
  utils.close_all_buffers_but_current_and_provided({ "NvimTree", "FTerm", "neo-tree" })
end, { desc = "Close all buffers except the current" })
bind("n", "<leader>bi", function()
  utils.get_buf_summary()
end, { desc = "Print a summary about the current buffer" })

-- Misc
bind("v", "<leader>j", "J")
-- bind("v", "J", ":m '>+1<CR>gv=gv")
-- bind("v", "K", ":m '<-2<CR>gv=gv")
bind("x", "<leader>p", '"_dP')
bind("n", "J", "mzJ`z")
bind("n", "<C-d>", "<C-d>zz")
bind("n", "<C-u>", "<C-u>zz")
bind("n", "n", "nzzzv")
bind("n", "N", "Nzzzv")
bind("n", "<leader>x", "<cmd>!chmod +x %<CR>", {
  silent = true,
  desc = "chmod +x the current file",
})

-- Inlay Hints

-- Utils-----------------------------------------------------------------------

bind( -- Copy link to current file and position in git
  "n",
  "<leader>lk",
  require("joermo.config.utils").copyFilePathAndLineNumber,
  { desc = "Copy [l]in[k] to current file and position." }
)
-------------------------------------------------------------------------------

-- LSP -----------------------------------------------------------------------
bind({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
bind("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
bind("n", "gK", vim.lsp.buf.signature_help)
bind("n", "<leader>cA", function()
  vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
end)
bind("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart LSPP" })
bind("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" }) -- jump to previous diagnostic in buffer
bind("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" }) -- jump to next diagnostic in buffer
bind("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" }) -- show  diagnostics for file
bind("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" }) -- show diagnostics for line
bind({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
if vim.lsp.inlay_hint then
  bind("n", "<leader>H", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  end, { desc = "Toggle Inlay Hints" })
end
------------------------------------------------------------------------------
