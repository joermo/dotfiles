local bind = vim.keymap.set

bind({ "v" }, "<leader>fc", function()
  require("joermo.config.utils").conform_format()
end, { desc = "Format Selection" })
bind({ "n" }, "<leader>F", function()
  require("joermo.config.utils").conform_format()
end, { desc = "Format Buffer" })
bind({ "n" }, "gf", function()
  require("joermo.config.utils").format_range_operator()
end, { desc = "Format Motion" })

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
        sh = { "shfmt" },
        zsh = { "shfmt" },
        bash = { "shfmt" },
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
