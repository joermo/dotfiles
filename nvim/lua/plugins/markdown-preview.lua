-- return {
--   "iamcco/markdown-preview.nvim",
--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--   build = function()
--     vim.fn["mkdp#util#install"]()
--   end,
--   keys = {
--     {
--       "<leader>mdp",
--       ft = "markdown",
--       "<cmd>MarkdownPreviewToggle<cr>",
--       desc = "Markdown Preview",
--     },
--   },
--   config = function()
--     vim.cmd([[do FileType]])
--   end,
-- }
--
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  keys = {
    {
      "<leader>mdp",
      ft = "markdown",
      "<cmd>MarkdownPreviewToggle<cr>",
      desc = "Markdown Preview",
    },
  },
  config = function()
    vim.cmd([[do FileType]])
  end,
}
