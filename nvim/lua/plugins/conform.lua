return {
  "stevearc/conform.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      liquid = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
      go = { "gofmt", "gopls" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      bash = { "shfmt" },
    },
    -- format_on_save = {
    --   lsp_fallback = true,
    --   async = false,
    --   timeout_ms = 1000,
    -- },
  },
}

-- opts = function()
--   local plugin = require("lazy.core.config").plugins["conform.nvim"]
--   if plugin.config ~= M.setup then
--     LazyVim.error({
--       "Don't set `plugin.config` for `conform.nvim`.\n",
--       "This will break **LazyVim** formatting.\n",
--       "Please refer to the docs at https://www.lazyvim.org/plugins/formatting",
--     }, { title = "LazyVim" })
--   end
--   ---@type conform.setupOpts
--   local opts = {
--     default_format_opts = {
--       timeout_ms = 3000,
--       async = false, -- not recommended to change
--       quiet = false, -- not recommended to change
--       lsp_format = "fallback", -- not recommended to change
--     },
--     formatters_by_ft = {
--       lua = { "stylua" },
--       fish = { "fish_indent" },
--       sh = { "shfmt" },
--     },
--     -- The options you set here will be merged with the builtin formatters.
--     -- You can also define any custom formatters here.
--     ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
--     formatters = {
--       injected = { options = { ignore_errors = true } },
--       -- # Example of using dprint only when a dprint.json file is present
--       -- dprint = {
--       --   condition = function(ctx)
--       --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
--       --   end,
--       -- },
--       --
--       -- # Example of using shfmt with extra args
--       -- shfmt = {
--       --   prepend_args = { "-i", "2", "-ci" },
--       -- },
--     },
--   }
--   return opts
-- end
