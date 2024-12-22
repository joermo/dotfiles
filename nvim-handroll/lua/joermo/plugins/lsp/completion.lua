return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  -- version = "v0.*",
  version = "v0.7", -- TODO update this once latest is fixed
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  ---@diagnostic disable: missing-fields
  opts = {
    keymap = {
      -- preset = "default",
      preset = "enter",
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- optionally disable cmdline completions
      -- cmdline = {},
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
        auto_brackets = { enabled = true },
      },
      providers = {
        lsp = { fallback_for = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
    signature = { enabled = true },
    completion = {
      trigger = {
        -- show_on_insert_on_trigger_character = false,
        show_on_insert_on_trigger_character = false,
      },
      accept = { auto_brackets = { enabled = true } },
    },
  },
  opts_extend = { "sources.default" },
}
