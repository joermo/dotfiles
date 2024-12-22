local bind = vim.keymap.set

bind("n", "<leader>lg", function()
  Snacks.lazygit.open()
end, { desc = "Open Lazygit" })

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    -- statuscolumn = { enabled = true },
    words = { enabled = true },
    lazygit = { enabled = true },
  },
}
