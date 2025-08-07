local servers = {
  "ts_ls",
  "html",
  "cssls",
  "tailwindcss",
  "svelte",
  "lua_ls",
  "graphql",
  "emmet_ls",
  "prismals",
  -- "basedpyright",
  "pyright",
  "ruff",
  "marksman",
  -- "rust_analyzer"
  "yamlls",
  "markdown-toc"
}

return {
  "neovim/nvim-lspconfig",
  config = function()
    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end
  end
}

