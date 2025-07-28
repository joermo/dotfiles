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
}

local tools = {
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

if vim.fn.executable('nix-build') == 1 then
  return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      for _, server in ipairs(servers) do
        local options = {
          capabilities = capabilities
        }
        -- Pyright specific options
        if server == "basedpyright" then
          options = {
            capabilities = capabilities,
            settings = {
              diagnosticMode = "openFilesOnly"
            }
          }
        else
          lspconfig[server].setup(options)
        end
      end
    end,
    opts = {
      inlay_hints = { enabled = false },
      document_hightlight = { enabled = false },
      servers = {},
    },
    setup = {
      rust_analyzer = function()
        return true
      end,
    },
  }
end


-- If not nixos, rely on mason and mason-lspconfig
return {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Configure mason and mason tool installer
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
      ensure_installed = servers,
    })
    mason_tool_installer.setup({
      ensure_installed = tools,
    })

    -- Configure lsp integrations
    local lspconfig = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    mason_lspconfig.setup_handlers({
      function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["basedpyright"] = function()
        lspconfig.basedpyright.setup({
          capabilities = capabilities,
          settings = {
            diagnosticMode = "openFilesOnly"
          }
        })
      end,
    })
  end,
  opts = {
    inlay_hints = { enabled = false },
    document_hightlight = { enabled = false },
    servers = {},
  },
  setup = {
    rust_analyzer = function()
      return true
    end,
  },
}



-- settings = {
--   python = {
--     analysis = {
--       typeCheckingMode = "standard",
--       autoSearchPaths = true,
--       useLibraryCodeForTypes = true,
--       diagnosticSeverityOverrides = {
--         reportMissingTypeStubs = "none", -- Suppress this specific diagnostic
--       },
--     },
--   },
-- },
