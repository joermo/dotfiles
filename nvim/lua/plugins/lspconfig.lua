return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      document_highlight = { enabled = false },
      servers = {
        basedpyright = {
          handlers = {
            -- Override severity of specific message types.
            -- In increasing order of severity: Hint, Info, Warn, Error
            ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
              if result and result.diagnostics then
                for _, diagnostic in ipairs(result.diagnostics) do
                  if diagnostic.severity == vim.diagnostic.severity.ERROR then
                    if diagnostic.message:match("deprecated") then
                      diagnostic.severity = vim.diagnostic.severity.INFO
                    elseif diagnostic.message:match("Stub file not found") then
                      diagnostic.severity = vim.diagnostic.severity.INFO
                    end
                  end
                end
              end
              vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
            end,
          },
        },
      },
      setup = {
        -- set up rust analyzer override to not automatically configure as per LazyVim docs
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
}
