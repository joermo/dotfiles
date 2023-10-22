local bind = vim.keymap.set

vim.g.mapleader = " "
bind("n", "<leader>pv", vim.cmd.Ex)

-- Default
bind("i", "kj", "<Esc>")
bind("i", "jk", "<Esc>")
bind("n", "<Leader>n", "<CMD>noh<CR>")
-- Windows
bind("n", "<Leader>wl", "<C-W>l")
bind("n", "<Leader>wh", "<C-W>h")
bind("n", "<Leader>wk", "<C-W>k")
bind("n", "<Leader>wj", "<C-W>j")
bind("n", "<Leader>wv", ":vsplit<CR>")
-- NvimTree
-- bind("n", "<C-n>", "<CMD>NvimTreeToggle<CR>")
bind("n", "'t", "<CMD>NvimTreeToggle<CR>")
bind("n", "tf", "<CMD>NvimTreeFindFile<CR>")
-- Terminal
-- bind("n", "<A-i>", "<CMD>FloatermToggle<CR>")
-- bind({ "n", "v", "i" }, "<A-o>", "<CMD>stopinsert<CR>")
bind("n", "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>")
bind('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
bind({ "t", "v", "i" }, "<Esc>", "<C-\\><C-n>")
-- bind({ "t", "v", "i" }, "kj", "<C-\\><C-n>")

-- Util
bind("v", "J", ":m '>+1<CR>gv=gv")
bind("v", "K", ":m '<-2<CR>gv=gv")
bind("n", "J", "mzJ`z")
bind("n", "n", "nzzzv")
bind("n", "N", "Nzzzv")
bind("n", "U", "<C-u>zz")
bind("n", "D", "<C-d>zz")
bind("n", "<C-d>", "<C-d>zz")
bind("n", "<C-u>", "<C-u>zz")
-- bind("n", "Q", ":enew<bar>bd #<CR>")
bind("n", "Q", "<cmd>silent enew<bar>bd #<CR>")

-- greatest remap ever
bind("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
bind({ "n", "v" }, "<leader>y", [["+y]])
bind("n", "<leader>Y", [["+Y]])

bind("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
bind("n", "<leader>f", vim.lsp.buf.format)

bind("n", "<C-k>", "<cmd>cnext<CR>zz")
bind("n", "<C-j>", "<cmd>cprev<CR>zz")
bind("n", "<leader>k", "<cmd>lnext<CR>zz")
bind("n", "<leader>j", "<cmd>lprev<CR>zz")

bind("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Trouble
bind("n", "<Leader>t", "<CMD>TroubleToggle<CR>")
bind("n", "qf", "<CMD>TroubleToggle quickfix<CR>")


-- Lazygit
bind("n", "<leader>g", "<CMD>LazyGit<CR>")
