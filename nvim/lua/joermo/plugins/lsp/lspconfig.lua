return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    require("neodev").setup({})
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
      severity_sort = false,
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

-- return {
--   'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',
--   dependencies = {
--     {"folke/neodev.nvim"},
--     {'williamboman/mason.nvim'},
--     {'williamboman/mason-lspconfig.nvim'},
--     -- {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
--     -- {'neovim/nvim-lspconfig', commit = '5e54173da4e0ffd8e9559c0a1fddfb3b7df97bec' },
--     {'neovim/nvim-lspconfig'},
--     {'hrsh7th/cmp-nvim-lsp'},
--     {"hrsh7th/cmp-buffer"},
--     {"hrsh7th/cmp-path"},
--     {'hrsh7th/nvim-cmp'},
--     {'L3MON4D3/LuaSnip'},
--     {"WhoIsSethDaniel/mason-tool-installer.nvim"},
--   },
--   config = function()
--   local lsp_zero = require("lsp-zero")
--   local mason = require("mason")
--   local mason_lspconfig = require("mason-lspconfig")
--   local mason_tool_installer = require("mason-tool-installer")
--   local cmp = require("cmp")
--   local defaults = require("cmp.config.default")()
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
--     -- list of servers for mason to install
--     ensure_installed = lsp_ensure_installed,
--     handlers = {
--       function(server_name)
--         require("lspconfig")[server_name].setup({})
--       end,
--       -- example_server = function()
--       --   require('lspconfig').example_server.setup({
--       --   })
--       -- end,
--     },
--   })
--   mason_tool_installer.setup({
--     ensure_installed = tools_ensure_installed,
--   })
--   cmp.setup({
--     auto_brackets = {}, -- configure any filetype to auto add brackets
--     completion = {
--       completeopt = "menu,menuone,noinsert",
--     },
--     mapping = cmp.mapping.preset.insert({
--       ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
--       ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
--       ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--       ["<C-f>"] = cmp.mapping.scroll_docs(4),
--       ["<C-Space>"] = cmp.mapping.complete(),
--       ["<C-e>"] = cmp.mapping.abort(),
--       ["<CR>"] = cmp.mapping.confirm({ select = true }),
--       ["<C-CR>"] = function(fallback)
--         cmp.abort()
--         fallback()
--       end,
--     }),
--     sources = cmp.config.sources({
--       { name = "nvim_lsp" },
--       { name = "path" },
--     }, {
--       { name = "buffer" },
--     }),
--     experimental = {
--       ghost_text = {
--         hl_group = "CmpGhostText",
--       },
--     },
--     sorting = defaults.sorting,
--   })
--   end
-- }
