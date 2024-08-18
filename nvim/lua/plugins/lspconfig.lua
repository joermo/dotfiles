return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    document_highlight = { enabled = false },
    servers = {
      bashls = {
        filetypes = { "sh", "zsh" },
      },
    },
  },
}
