return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
  config = function()
    require("lualine").setup({
      -- options = {
      --   theme = "gruvbox",
      -- },
    })
  end,
}
