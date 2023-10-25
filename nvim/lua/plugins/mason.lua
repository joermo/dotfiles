return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "black")
    table.insert(opts.ensure_installed, "shfmt")
    table.insert(opts.ensure_installed, "clang-format")
    table.insert(opts.ensure_installed, "ruff-lsp")
  end,
}
