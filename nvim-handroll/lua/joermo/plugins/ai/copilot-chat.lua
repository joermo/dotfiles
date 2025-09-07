return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  config = function()
    local opts = {}
    local copilot_chat = require("CopilotChat")
    copilot_chat.setup(opts)
    local bind = vim.keymap.set
    bind("n", "<leader>cc", function()
      copilot_chat.toggle()
    end, { desc = "Toggle GH Copilot Chat" })
    bind("n", "<leader>cr", function()
      copilot_chat.reset()
    end, { desc = "Reset GH Copilot Chat" })
    bind("n", "<leader>ca", function()
      copilot_chat.close()
    end, { desc = "Close GH Copilot Chat" })
  end,
}
