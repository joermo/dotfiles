local bind = vim.keymap.set

bind("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open Undotree" })

return {
  "mbbill/undotree",
}
