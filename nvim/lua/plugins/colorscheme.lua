return {
  -- add gruvbox
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "mhartington/oceanic-next" },
  -- { "NLKNguyen/papercolor-theme" },
  -- { "loctvl842/monokai-pro.nvim" },
  -- { "ku1ik/vim-monokai" },
  { "catppuccin/nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox",
      -- colorscheme = "OceanicNext",
      -- colorscheme = "PaperColor",
      -- colorscheme = "monokai-pro",
      -- colorscheme = "monokai",
      colorscheme = "catppuccin-mocha",
    },
  },
}
