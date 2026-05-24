local bind = vim.keymap.set

bind("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = false,
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
