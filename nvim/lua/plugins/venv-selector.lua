-- return {}

return {
  "linux-cultist/venv-selector.nvim",
  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = true,
        on_venv_activate_callback = function()
          -- local venv = require("venv-selector").venv()
          -- vim.notify("Venv: " .. venv, vim.log.levels.INFO)
        end,
      },
    },
  },
}
