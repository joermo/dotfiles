-- return {
--   "akinsho/bufferline.nvim",
--   branch = "main",
--   commit = "f6f00d9ac1a51483ac78418f9e63126119a70709",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     local bufferline = require("bufferline")
--     bufferline.setup({
--       options = {
--         diagnostics = "nvim_lsp",
--         separator_style = "slant",
--         diagnostics_indicator = function(count, level)
--           local icon = level:match("error") and " " or " "
--           return " " .. icon .. count
--         end,
--       },
--     })
--   end,
-- }

return {
  "akinsho/bufferline.nvim",
  branch = "release-please--branches--main--components--bufferline.nvim",
  commit = "2670f1f177e5d1d5f3dea26ddb66485493d8fa52",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      diagnostics = "nvim_lsp",
      separator_style = "slant",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
    },
  },
}


