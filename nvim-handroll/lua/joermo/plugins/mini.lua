local bind = vim.keymap.set

bind("n", "<leader>mm", function()
  require("mini.map").toggle()
end)

return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup()
    require("mini.align").setup()
    require("mini.statusline").setup()
    require("mini.bracketed").setup()
    -- require("mini.completion").setup()
    require("mini.move").setup({
      mappings = {
        -- Visual mappings
        left = "H",
        right = "L",
        down = "J",
        up = "K",
        -- Normal mappings
        line_left = "<", -- TODO see if this gets in the way
        line_right = ">", -- TODO see if this gets in the way
        line_down = "",
        line_up = "",
      },
    })
    require("mini.pairs").setup()
    require("mini.splitjoin").setup()
    require("mini.surround").setup() -- sa<motion|visual><char>
    require("mini.tabline").setup()
  end,
}
