-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

-- NvimTree
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NVIM_TREE", { clear = true }),
  pattern = "NvimTree",
  callback = function()
    vim.api.nvim_win_set_option(0, "wrap", false)
  end,
})

-- Set file type for zshrc
vim.cmd([[au BufRead,BufNewFile .zshrc set filetype=zsh]])

vim.cmd([[au BufRead,BufNewFile zsh set filetype=sh]])

-- -- Startup Commands
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.fn.argc() >= 1 then
--       if vim.fn.isdirectory(vim.v.argv[0]) then
--         vim.cmd("terminal")
--       end
--     end
--   end,
-- })
