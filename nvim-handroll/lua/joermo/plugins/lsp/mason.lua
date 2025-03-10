local lsp_ensure_installed = {
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
}

local tools_ensure_installed = {
  "prettier",
  "stylua",
  "isort",
  "black",
  "pylint",
  "eslint_d",
  "shellcheck",
  "shfmt",
  "markdownlint-cli2",
  "markdown-toc",
}

return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  -- event = { "BufReadPost", "BufNewFile" },
  -- cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    mason_lspconfig.setup({
      automatic_installation = true,
      ensure_installed = lsp_ensure_installed,
    })
    mason_tool_installer.setup({
      ensure_installed = tools_ensure_installed,
    })
  end,
}
