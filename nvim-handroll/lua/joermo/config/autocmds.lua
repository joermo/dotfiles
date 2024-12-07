local function augroup(name)
  return vim.api.nvim_create_augroup("joermo_" .. name, { clear = true })
end

-- Set behavior for specific file patterns
vim.cmd([[au BufRead,BufNewFile .bashrc set filetype=bash]])
vim.cmd([[au BufRead,BufNewFile .zshrc set filetype=sh]])
vim.cmd([[au BufRead,BufNewFile zsh set filetype=sh]])

-- Disable diagnostics for .env files
local group = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.env", ".env*" },
  group = group,
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

-------------------------------------------------------------------------------
-- Function to highlight yanked text with default visual highlight color (cleaner looking)
function OnYank()
  local default_highlight = vim.fn.synIDattr(vim.fn.hlID("Visual"), "bg")
  vim.highlight.on_yank({
    higroup = "Visual",
    timeout = 100,
    on_visual = true,
    hl_default = default_highlight,
  })
end
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    OnYank()
  end,
})
-------------------------------------------------------------------------------

-- Disable autoformat for specific extensions
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python", "py" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Disable autoformatting for all buffers
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Enable autoformatting for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua" },
  callback = function()
    vim.b.autoformat = true
  end,
})

-- Given diagnostic types are (in inc. severity):  Hint, Info, Warn, Error
-- Disable underline diagnostics for anything above INFO
-- Disable virtual text diagnostics for anything below WARN
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    vim.diagnostic.config({
      underline = {
        severity = { max = vim.diagnostic.severity.INFO },
      },
      virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
      },
    })
  end,
})

-- TODO: refactor to use the nvim builtin for this
-- If a directory is open, check for a file named local-nvim-opts.lua.
-- If the file exists, source all its contents.
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local local_opts_path = vim.fn.getcwd() .. "/local-nvim-opts.lua"
    if vim.fn.isdirectory(vim.fn.expand("%:p")) == 1 then
      if vim.fn.filereadable(local_opts_path) == 1 then
        vim.print("sourcing")
        dofile(local_opts_path)
      end
    end
  end,
})

-- Add additional patterns for docker compose language server filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "docker-compose*.yml", "docker-compose*.yaml" },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
})
