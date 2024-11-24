local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

function IsOnPath()
  vim.fn.executable("rg")
end

if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep --hidden --glob ‘!.git’"
end

local spec = {
  -- add LazyVim and import its plugins
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
  -- import/override with your plugins
  { import = "plugins" },
}

local function add_conditional_extras(spec, extras)
  for extra, condition in pairs(extras) do
    if condition == "" or vim.fn.executable(condition) then
      table.insert(spec, { import = "lazyvim.plugins.extras.lang." .. extra })
    end
  end
end

local lazy_extras = {
  json = "",
  typescript = "",
  go = "go",
  rust = "cargo",
  terraform = "terraform",
  python = "python",
  markdown = "",
}

add_conditional_extras(spec, lazy_extras)

require("lazy").setup({
  spec = spec,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
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
