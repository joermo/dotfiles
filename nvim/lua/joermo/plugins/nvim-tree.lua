return {
  {
    "kyazdani42/nvim-tree.lua",
    event = "CursorHold",
    opts = {
      diagnostics = {
        enable = true,
      },
      update_focused_file = {
        enable = true,
        update_cwd = false,
      },
      view = {
        width = 35,
        side = "left",
        adaptive_size = true,
      },
      filters = {
        custom = { ".git$", "node_modules$", "^target$" },
      },
      git = {
        ignore = false,
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
          resize_window = true,
        },
      },
      renderer = {
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = false,
          },
          glyphs = {
            default = "",
            git = {
              unstaged = "~",
              staged = "+",
              unmerged = "!",
              renamed = "≈",
              untracked = "?",
              deleted = "-",
            },
          },
        },
        indent_markers = {
          enable = true,
        },
      },
    },
  },
}
