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

-- return {
--   "akinsho/bufferline.nvim",
--   branch = "release-please--branches--main--components--bufferline.nvim",
--   commit = "2670f1f177e5d1d5f3dea26ddb66485493d8fa52",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   version = "*",
--   opts = {
--     options = {
--       mode = "tabs",
--       diagnostics = "nvim_lsp",
--       separator_style = "slant",
--       diagnostics_indicator = function(count, level)
--         local icon = level:match("error") and " " or " "
--         return " " .. icon .. count
--       end,
--     },
--   },
-- }

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  },
  opts = {
    options = {
      -- stylua: ignore
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
