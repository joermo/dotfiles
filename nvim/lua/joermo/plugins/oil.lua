return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = false
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keymaps = {
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
  }
}
