local bind = vim.keymap.set

-- Custom function to invoke conform formatting
local function conform_format()
  local conform = require("conform")
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 10000,
  })
end

-- Custom function to format by range via objects and motions
local function format_range_operator()
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
end


bind({ "v" }, "<leader>fc", function() conform_format() end, { desc = "Format Selection" })
bind({ "n" }, "<leader>F", function() conform_format() end, { desc = "Format Buffer" })
bind({ "n" }, "gf", function() format_range_operator() end, { desc = "Format Motion" })

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
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "gofmt", "gopls" },
        sh = { "beautysh" },
        zsh = { "beautysh" },
        bash = { "beautysh" },
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        sql = { "sqlfluff" },
      },
      -- format_on_save = {
      --   lsp_fallback = true,
      --   async = false,
      --   timeout_ms = 1000,
      -- },
      formatters = {
        sqlfluff = {
          command = "sqlfluff",
          args = { "format", "-" },
        },
      },
    })
  end,
}
