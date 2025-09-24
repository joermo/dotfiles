local bind = vim.keymap.set

return {
  'MagicDuck/grug-far.nvim',
  config = function()
    local grug_far = require('grug-far')
    grug_far.setup({});
    bind("v", "<leader>r", function()
      grug_far.with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
    end, { desc = "Search for selection and replace" })
  end
}
