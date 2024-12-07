-- Define custom diagnostics to be ignored for basedpyright
local function basedpyright_filtered_diagnostics(diagnostic)
  local basedpyright_ignored_codes = {
    ["reportImplicitRelativeImport"] = true,
  }
  return not basedpyright_ignored_codes[diagnostic.code]
end
-- Perform custom filter for basedpyright
local function perform_basedpyright_diag_filter(a, params, client_id, c, config)
  params.diagnostics = vim.tbl_filter(basedpyright_filtered_diagnostics, params.diagnostics)
  vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- require("neodev").setup({}) -- must be set up first, else error with keybind resets
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    local ruff = "ruff_lsp"
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        })
      end,
      ["basedpyright"] = function()
        -- configure basedpyright with special options
        lspconfig["basedpyright"].setup({
          on_attach = function(client, bufnr)
            client.handlers["textDocument/publishDiagnostics"] = perform_basedpyright_diag_filter
          end,
        })
      end,
      -- Custom for ruff; disable hover from ruff
      [ruff] = function()
        require("joermo.config.lsp-utils").on_attach(function(client, _)
          if client.name == ruff then
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    })
  end,
}
