local bind = vim.keymap.set

return {
  "sindrets/diffview.nvim",
  config = function()
    bind("n", "<leader>df", function() end)
  end,
}

-- :Diffview...
