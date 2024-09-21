return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  config = function()
    require("venv-selector").setup({
      notify_user_on_activate = true,
    })
  end,
}
