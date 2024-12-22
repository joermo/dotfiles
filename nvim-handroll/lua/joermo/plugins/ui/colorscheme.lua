return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function ()
    vim.cmd.colorscheme("catppuccin")
  end
}

-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   config = function()
--     vim.cmd("colorscheme rose-pine-main")
--   end
-- }

-- -- For monokai
-- return {
--   "loctvl842/monokai-pro.nvim",
--   config = function()
--     -- require("monokai-pro").setup()
--     vim.cmd("colorscheme monokai-pro")
--   end
-- }

-- -- for catppuccin
-- return {
--   "catppuccin/nvim",
--   config = function()
--     vim.cmd("colorscheme catppuccin-mocha")
--   end,
-- }

-- -- for flexoki
-- return {
--   "kepano/flexoki-neovim",
--   config = function()
--     vim.cmd("colorscheme flexoki-dark")
--   end,
-- }

-- -- For Gruvbox
-- return {
--   "ellisonleao/gruvbox.nvim",
--   priority = 1000,
--   config = function()
--     require("gruvbox").setup({})
--     vim.o.background = "dark"
--     vim.cmd([[colorscheme gruvbox]])
--   end,
-- }

-- -- For oxocarbon
-- return {
--   "B4mbus/oxocarbon-lua.nvim",
--   priority = 1000,
--   config = function()
--     -- require("oxocarbon-lua").setup({})
--     vim.o.background = "dark"
--     vim.cmd([[colorscheme oxocarbon-lua]])
--   end,
-- }

-- -- For Kanagawa
-- return {
--   "rebelot/kanagawa.nvim",
--   priority = 1000,
--   config = function()
--     require("kanagawa").setup({})
--     -- vim.o.background = "dark"
--     -- vim.cmd("colorscheme kanagawa-wave")
--     vim.cmd("colorscheme kanagawa-dragon")
--   end,
-- }
