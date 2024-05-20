return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "gofmt", "gopls" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        bash = { "shfmt" },
      },
      -- format_on_save = {
      --   lsp_fallback = true,
      --   async = false,
      --   timeout_ms = 1000,
      -- },
    })
  end,

  joermo_format_utils = {
    -- Custom function to invoke conform formatting
    conform_format = function()
      local conform = require("conform")
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end,
    -- Custom function to format by range via objects and motions
    format_range_operator = function()
      local conform = require("conform")
      local old_func = vim.go.operatorfunc
      _G.op_func_formatting = function()
        local opts = {
          range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "["),
            ["end"] = vim.api.nvim_buf_get_mark(0, "]"),
          },
        }
        conform.format(opts)
        vim.go.operatorfunc = old_func
        _G.op_func_formatting = nil
      end
      vim.go.operatorfunc = "v:lua.op_func_formatting"
      vim.api.nvim_feedkeys("g@", "n", false)
    end,
  },
}
