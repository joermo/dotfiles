return {
  -- auto completion config
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    -- Not all LSP servers add brackets when completing a function.
    -- To better deal with this, LazyVim adds a custom option to cmp,
    -- that you can configure. For example:
    --
    -- ```lua
    -- opts = {
    --   auto_brackets = { "python" }
    -- }
    -- ```

    opts = function()
      local cmp_utils = require("joermo.config.lsp-utils")
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        auto_brackets = {
          "python",
        }, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp_utils.confirm(),
          ["<S-CR>"] = cmp_utils.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        -- formatting = {
        --   -- format = function(_, item)
        --   --   local icons = require("lazyvim.config").icons.kinds
        --   --   if icons[item.kind] then
        --   --     item.kind = icons[item.kind] .. item.kind
        --   --   end
        --   --   return item
        --   -- end,
        -- },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
    config = function(_, opts)
      local cmp_utils = require("joermo.config.lsp-utils")
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      local parse = require("cmp.utils.snippet").parse
      require("cmp.utils.snippet").parse = function(input)
        local ok, ret = pcall(parse, input)
        if ok then
          return ret
        end
        return cmp_utils.snippet_preview(input)
      end

      local cmp = require("cmp")
      cmp.setup(opts)
      cmp.event:on("confirm_done", function(event)
        if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
          cmp_utils.auto_brackets(event.entry)
        end
      end)
      cmp.event:on("menu_opened", function(event)
        cmp_utils.add_missing_snippet_docs(event.window)
      end)
    end,
  },
  -- snippets config
  {
    {
      "nvim-cmp",
      dependencies = {
        {
          "garymjr/nvim-snippets",
          opts = {
            friendly_snippets = true,
            global_snippets = { "all", "global" },
          },
          dependencies = { "rafamadriz/friendly-snippets" },
        },
        "L3MON4D3/LuaSnip",
      },
      opts = function(_, opts)
        opts.snippet = {
          expand = function(item)
            return require("joermo.config.lsp-utils").expand(item.body)
          end,
        }
        table.insert(opts.sources, { name = "snippets" })
        table.insert(opts.sources, { name = "luasnip" })
      end,
      keys = {
        {
          "<Tab>",
          function()
            return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
          end,
          expr = true,
          silent = true,
          mode = { "i", "s" },
        },
        {
          "<S-Tab>",
          function()
            return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<Tab>"
          end,
          expr = true,
          silent = true,
          mode = { "i", "s" },
        },
      },
    },
  },
}
