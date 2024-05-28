-- return {}

-- for catppuccin
return {
  "catppuccin/nvim",
  config = function()
    vim.cmd("colorscheme catppuccin-mocha")
  end,
}

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
