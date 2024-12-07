return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  config = function()
    local venv_selector = require("venv-selector")
    venv_selector.setup({})
  end,
}
