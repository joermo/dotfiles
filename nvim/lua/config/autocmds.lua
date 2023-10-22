-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NVIM_TREE", { clear = true }),
  pattern = "NvimTree",
  callback = function()
    vim.api.nvim_win_set_option(0, "wrap", false)
  end,
})
