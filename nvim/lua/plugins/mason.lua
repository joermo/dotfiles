local lsp_ensure_installed = {
  "typescript-language-server",
  "html-lsp",
  "css-lsp",
  "tailwindcss-language-server",
  "svelte-language-server",
  "lua-language-server",
  "graphql-language-service-cli",
  "emmet-ls",
  "prisma-language-server",
  "basedpyright",
  -- "pyright",
  "ruff",
  "marksman",
  "yaml-language-server",
  "rust-analyzer",
  "ansible-language-server",
  -- "terraform-ls",
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
}

return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  opts = function(_, opts)
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, lsp_ensure_installed)
    mason_tool_installer.setup({
      ensure_installed = tools_ensure_installed,
    })
  end,
  -- config = function()
  --   local mason = require("mason")
  --   local mason_lspconfig = require("mason-lspconfig")
  --   local mason_tool_installer = require("mason-tool-installer")
  --   mason.setup({
  --     ui = {
  --       icons = {
  --         package_installed = "✓",
  --         package_pending = "➜",
  --         package_uninstalled = "✗",
  --       },
  --     },
  --   })
  --   mason_lspconfig.setup({
  --     ensure_installed = lsp_ensure_installed,
  --   })
  --
  --   mason_tool_installer.setup({
  --     ensure_installed = tools_ensure_installed,
  --   })
  -- end,
}
