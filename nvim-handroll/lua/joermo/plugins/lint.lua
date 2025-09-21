return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      -- python = { "pylint" },
      python = { "ruff", "pylint" },
      sh = { "shellcheck" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>L", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })

    -- Set pylint to work in virtualenv
    require('lint').linters.pylint.cmd = 'python'
    -- require('lint').linters.pylint.args = {'-m', 'pylint', '-f', 'json2'} -- TODO revisit this later; breaking on some machines
    require('lint').linters.pylint.args = {'-m', 'pylint', '-j', '5'}
  end,
}
