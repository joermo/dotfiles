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
  "basedpyright",
  -- "pyright",
  "ruff",
  "marksman",
  -- "rust_analyzer"
  "yamlls",
  "yaml-language-server",
  "markdown-toc",
}

local lsp_overrides = {
  basedpyright = {
    settings = {
      ["basedpyright"] = {
        typeCheckingMode = "basic",
      },
    },
  },
}

return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Apply custom overrides
    for server, config in pairs(lsp_overrides) do
      vim.lsp.config(server, config)
    end
    -- Enable all servers
    vim.lsp.enable(servers)
  end,
}
