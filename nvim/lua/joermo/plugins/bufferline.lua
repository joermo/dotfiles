return {
  "akinsho/bufferline.nvim",
  branch='main',
  commit='f6f00d9ac1a51483ac78418f9e63126119a70709',
  -- lazy=true,
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
      },
    })
  end,
}
