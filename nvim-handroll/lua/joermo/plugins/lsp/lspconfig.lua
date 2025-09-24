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
    for _, server in ipairs(servers) do
      if lsp_overrides[server] then
        vim.print(lsp_overrides[server])
        vim.lsp.config(server, lsp_overrides[server])
      end
      vim.lsp.enable(server)
    end
  end,
}
