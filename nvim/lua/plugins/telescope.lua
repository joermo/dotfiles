local actions = require("telescope.actions")
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    -- change a keymap
    { "'s", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "'b", "<cmd>Telescope buffers<cr>", desc = "Find Open Buffers" },
    { "'r", "<cmd>Telescope live_grep<cr>", desc = "Live grep across all files" },
    {
      "'f",
      function()
        require("telescope.builtin").live_grep({ grep_open_files = true })
      end,
      desc = "Live grep across open files",
    },
  },
  opts = function()
    return {
      defaults = {
        mappings = {
          i = {
            ["<ESC>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
            ["<C-s>"] = actions.send_selected_to_qflist,
            ["<C-q>"] = actions.send_to_qflist,
          },
        },
      },
    }
  end,
}
