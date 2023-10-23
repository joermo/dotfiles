-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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
bind({ "n", "i", "t" }, "H", "<CMD>bprevious<CR>")
bind({ "n", "i", "t" }, "L", "<CMD>bnext<CR>")
-- NvimTree
bind("n", "<C-n>", "<CMD>NvimTreeToggle<CR>")
bind("n", "tf", "<CMD>NvimTreeFindFile<CR>")
-- Terminal
bind({ "n", "v", "i", "t" }, "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>")
bind({ "n", "v", "i", "t" }, "<A-o>", "<CMD>stopinsert<CR>")
bind({ "t", "v", "i", "t" }, "<Esc>", "<C-\\><C-n>")
bind({ "t", "v", "i", "t" }, "kj", "<C-\\><C-n>")
-- Lazygit
bind("n", "<leader>g", "<CMD>LazyGit<CR>")
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
-- bind("n", "<leader>f", function()
--   vim.lsp.buf.format()
-- end)

-- LSP
bind("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
bind("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")

-- Formatting
local range_formatting = function()
  local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
  vim.lsp.buf.format({
    range = {
      ["start"] = { start_row, 0 },
      ["end"] = { end_row, 0 },
    },
    async = true,
  })
end
bind("v", "<leader>fc", range_formatting, { desc = "Range Formatting" })

local function format_range_operator()
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local rangeOpts = {
      range = {
        ["start"] = vim.api.nvim_buf_get_mark(0, "["),
        ["end"] = vim.api.nvim_buf_get_mark(0, "]"),
      },
    }
    local plugin = require("lazy.core.config").plugins["conform.nvim"]
    local Plugin = require("lazy.core.plugin")
    local Util = require("lazyvim.util")
    local opts = Plugin.values(plugin, "opts", false)
    -- local buf = vim.fn.expand("%")
    opts["range"] = rangeOpts["range"]
    -- require("conform").format(Util.merge(opts.format, { bufnr = buf }))
    require("conform").format(Util.merge(opts.format))
    require("conform").format(opts)
    -- vim.lsp.buf.format(opts)
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil
  end
  vim.go.operatorfunc = "v:lua.op_func_formatting"
  vim.api.nvim_feedkeys("g@", "n", false)
end

-- Disable diagnostics for .env files
local group = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env*",
  group = group,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})

bind("n", "gf", format_range_operator, { desc = "Range Formatting" })
