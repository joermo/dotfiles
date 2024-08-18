-- -- Keymaps are automatically loaded on the VeryLazy event
-- -- Default keymaps that are always set: htps://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- -- Add any additional keymaps here
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
bind({ "n" }, "<leader>Q", "<CMD>silent!%bd|e#<CR>", { desc = "Close all buffers except current" })

-- File tree
bind("n", "<C-n>", vim.cmd.NvimTreeToggle, { desc = "Toggle file tree" })
bind("n", "tf", vim.cmd.NvimTreeFindFile, { desc = "Reveal current file in file tree" })
-- bind("n", "<C-n>", "<CMD>Neotree toggle<CR>", { desc = "Toggle file tree" })
-- bind("n", "tf", "<CMD>Neotree reveal<CR>", { desc = "Reveal current file in file tree" })

-- Terminal
bind({ "n", "v", "i", "t" }, "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>")
bind({ "n", "v", "i", "t" }, "<A-o>", "<CMD>stopinsert<CR>")
bind({ "t", "v", "i", "t" }, "<Esc>", "<C-\\><C-n>")
-- bind({ "t", "i", "t" }, "kj", "<C-\\><C-n>")
bind({ "i" }, "kj", "<C-\\><C-n>")

-- Trouble
bind("n", "<Leader>t", "<CMD>Trouble<CR>")
bind("n", "qf", "<CMD>Trouble quickfix<CR>")

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
bind("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Formatting
local conform_format = require("config.utils").conform_format
local format_range_operator = require("config.utils").format_range_operator
vim.keymap.set({ "v" }, "<leader>fc", conform_format, { desc = "Format Selection" })
vim.keymap.set({ "n" }, "<leader>F", conform_format, { desc = "Format Buffer" })
vim.keymap.set({ "n" }, "gf", format_range_operator, { desc = "Format Motion" })

-- Lazygit
bind("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Open lazy git" })

-- -- Oil
-- bind("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Refactoring
bind({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- Inlay Hints
if vim.lsp.inlay_hint then
  bind("n", "<leader>H", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  end, { desc = "Toggle Inlay Hints" })
end

-- Copy link to current file and position in git
bind("n", "<leader>lk", require("config.utils").copyFilePathAndLineNumber, { desc = "LSP Info" })

-- Undotree
bind("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open Undotree" })

-- LSP -----------------------------------------------------------------------
bind("n", "gd", function()
  require("telescope.builtin").lsp_definitions({ reuse_win = true })
end)
bind("n", "gi", function()
  require("telescope.builtin").lsp_implementations({ reuse_win = true })
end)
bind("n", "gt", function()
  require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
end)
-- bind("n", "gD", vim.lsp.buf.declaration) TODO
bind("n", "gr", function()
  require("telescope.builtin").lsp_references({ reuse_win = true })
end, { desc = "References" })
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
------------------------------------------------------------------------------

-- Telescope------------------------------------------------------------------
bind("n", "'s", "<CMD>Telescope find_files<CR>", { desc = "Find Files" })
bind("n", "'b", "<CMD>Telescope find_buffers<CR>", { desc = "Find Open Buffers" })
bind("n", "'r", "<CMD>Telescope live_grep<CR>", { desc = "Find Open Buffers" })
bind("n", "'f", function()
  require("telescope.builtin").live_grep({ grep_open_files = true })
end, { desc = "Live grep across open files" })
bind("n", "'c", function()
  require("telescope.builtin").current_buffer_fuzzy_find({})
end, { desc = "Fuzzy find in current buffer" })
bind("n", "<leader>o", function()
  require("telescope.builtin").lsp_document_symbols({})
end, { desc = "Document Symbols" })
bind("n", "<leader>O", function()
  require("telescope.builtin").lsp_workspace_symbols({})
end, { desc = "Workspace Symbols" })
------------------------------------------------------------------------------
