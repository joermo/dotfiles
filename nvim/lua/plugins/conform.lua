return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["python"] = { "black", "isort" },
      ["sh"] = { "shfmt" },
      ["javascript"] = { "prettier", "prettierd" },
      ["go"] = { "gofmt" },
      ["yaml"] = { "yamllint", "yamlfmt" },
    },
  },
}
