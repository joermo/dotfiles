return {
  "linux-cultist/venv-selector.nvim",
  branch = "main",
  config = function()
    local venv_selector = require("venv-selector")
    venv_selector.setup({})
  end,
}
