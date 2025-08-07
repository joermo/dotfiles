local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local specs = {
  { import = "joermo.plugins" },
  { import = "joermo.plugins.lsp" },
  { import = "joermo.plugins.ui" },
  { import = "joermo.plugins.qol" },
  { import = "joermo.plugins.telescope" },
  { import = "joermo.plugins.ai" },
}

-- require("lazy").setup(specs, {
--   checker = {
--     enabled = false,
--     notify = false,
--   },
--   change_detection = {
--     notify = false,
--   },
-- })

-- Setup lazy.nvim
require("lazy").setup({
  spec = specs,
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
  change_detection = { notify = false },
})
