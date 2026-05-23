return {
  -- Requires tree-sitter-cli installed
  -- (brew install tree-sitter-cli)
  "arborist-ts/arborist.nvim",
  lazy = false,
  config = function()
    require("arborist").setup({
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        --"jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "go",
        "python",
        "ninja",
        "rst",
        "rust",
        "ron",
        --"terraform",
      },
      auto_install = true,
    })
  end,
}
