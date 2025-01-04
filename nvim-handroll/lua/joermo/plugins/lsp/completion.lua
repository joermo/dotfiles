return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "enter" },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- cmdline = {},  -- disable command line
      providers = {
        lsp = { fallbacks = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
    completion = {
      trigger = { show_on_insert_on_trigger_character = false },
      accept = { auto_brackets = { enabled = true } },
      list = {
        selection = function(ctx)  -- Disable auto select by default
          return ctx.mode == "cmdline" and "auto_insert" or "preselect"
        end,
      },
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
