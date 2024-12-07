local bind = vim.keymap.set

-- Terminal
bind({ "n", "v", "i", "t" }, "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>")
bind({ "n", "v", "i", "t" }, "<A-o>", "<CMD>stopinsert<CR>")
bind({ "t", "v", "i", "t" }, "<Esc>", "<C-\\><C-n>")
-- bind({ "t", "i", "t" }, "kj", "<C-\\><C-n>")
bind({ "i" }, "kj", "<C-\\><C-n>")

return {
  "numToStr/FTerm.nvim",
  options = {
    border = "double",
    dimensions = {
      height = 0.9,
      width = 0.9,
    },
  },
}
