return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup()
    require("mini.align").setup() -- gA<motion|visual>
    require("mini.statusline").setup()
    require("mini.bracketed").setup()
    require("mini.move").setup({
      mappings = {
        -- Visual mappings
        left = "H",
        right = "L",
        down = "J",
        up = "K",
        -- Normal mappings
        line_left = "<", -- TODO see if this gets in the way
        line_down = "",
        line_up = "",
        line_right = ">", -- TODO see if this gets in the way
      },
    })
    require("mini.splitjoin").setup() -- gS
    require("mini.surround").setup() -- sa<motion|visual><char>
    require("mini.tabline").setup()
    -- require("mini.pairs").setup()
  end,
}
