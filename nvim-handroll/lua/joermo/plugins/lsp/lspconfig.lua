return {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
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
            openFilesOnly
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
