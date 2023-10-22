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

-- File indent levels
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.formatoptions:append({ c = true, r = true, o = true, q = true })
  end,
})

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
