local bind = vim.keymap.set

bind("n", "<leader>lg", function()
  Snacks.lazygit.open()
end, { desc = "Open Lazygit" })
bind("n", "<leader>lg", function()
  Snacks.lazygit.open()
end, { desc = "Open Lazygit" })
bind({ "n", "v", "i", "t" }, "<A-i>", function()
  Snacks.terminal()
end, { desc = "Open Floating Terminal" })
bind("n", "<leader>gb", function()
  Snacks.git.blame_line()
end, { desc = "Open Git Blame" })
-- bind("n", "<C-n>", function()
--   Snacks.explorer.open()
-- end, { desc = "Toggle File Explorer" })
bind("n", "<leader>r", function()
  Snacks.terminal("tuicr", {
    win = {
      position="float",
      width=0.9,
      height=0.9,
      border="rounded",
    }
  })
end, { desc = "Open tuicr to review changes." })

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
    lazygit = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        style = "terminal",
        position = "float",
        relative = "editor",
      },
    },
    git = {
      enabled = true,
    },
    gitbrowse = {
      enabled = true,
    },
    -- explorer = {
    --   enabled = true,
    -- },
    picker = {
      sources = {
        -- explorer = {},
      },
    },
  },
}
