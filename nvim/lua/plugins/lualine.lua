return {
  "nvim-lualine/lualine.nvim",
  -- dependencies = { 'nvim-tree/nvim-web-devicons' }
  opts = {
    lualine_a = {
      "filename",
      {
        function()
          local rec = vim.fn.reg_recording()
          if rec ~= "" then
            return "Recording @ " .. rec
          end
          return ""
        end,
        -- color = { fg = "#ff9e64", gui = "bold" }, -- Customize the color as needed
      },
    },
  },
}
