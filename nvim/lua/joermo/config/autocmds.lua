-- NvimTree
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NVIM_TREE", { clear = true }),
  pattern = "NvimTree",
  callback = function()
    vim.api.nvim_win_set_option(0, "wrap", false)
  end,
})

-- Set behavior for specific file patterns
vim.cmd([[au BufRead,BufNewFile .bashrc set filetype=bash]])
vim.cmd([[au BufRead,BufNewFile .zshrc set filetype=zsh]])
vim.cmd([[au BufRead,BufNewFile zsh set filetype=sh]])

-- Disable autoformat for specific extensions
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python", "py" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Disable diagnostics for .env files
local group = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env*",
  group = group,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})
