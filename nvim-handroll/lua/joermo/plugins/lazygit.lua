local bind = vim.keymap.set

bind("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Open lazy git" })

return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  }
}


