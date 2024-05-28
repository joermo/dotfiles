local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- check if binary is executable
local function isExecutable(binary)
  return vim.fn.executable(binary) == 1
end

-- add to provided spec if binary is executable
local function enableIfExecutable(spec, binary, toEnable)
  if isExecutable(binary) then
    table.insert(spec, toEnable)
  end
end

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Separately define lazy plugin spec to conditionally add extras
local lazy_spec = {
  -- add LazyVim and import its plugins
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  -- import any extras modules here
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  -- import/override with your plugins
  { import = "joermo.plugins" },
}
-- Conditionally add to lazy spec if prereqs are met

enableIfExecutable(lazy_spec, "go", { import = "lazyvim.plugins.extras.lang.go" })
enableIfExecutable(lazy_spec, "python", { import = "lazyvim.plugins.extras.lang.python" })

require("lazy").setup({
  spec = lazy_spec,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
