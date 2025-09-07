return {
  "zbirenbaum/copilot.lua",
  cond = (os.getenv("ENABLE_COPILOT") == "true"),
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  config = function()
    local copilot = require("copilot")
    local opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = false,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    }
    copilot.setup(opts)
    local bind = vim.keymap.set
    bind("n", "<leader>cp", function()
      require("copilot.panel").toggle()
    end, { desc = "Toggle GH Copilot Suggestion Panel" })
  end,
}
