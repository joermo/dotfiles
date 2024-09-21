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
-- Function to highlight yanked text with default visual highlight color
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

-- Automatically source the cached venv
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Auto select virtualenv Nvim open",
  pattern = "*",
  callback = function()
    local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
    if venv ~= "" then
      vim.cmd([[silent! lua require('venv-selector').retrieve_from_cache()]])
    end
  end,
  once = true,
})

-- -- Enable autoformatting for lua files
-- vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
--   -- pattern = { "lua" },
--   callback = function()
--     print('setting it ')
--     -- disable virtual text for anything non-error
--     vim.diagnostic.config({
--       virtual_text = {
--         min = vim.diagnostic.severity.WARN,
--       },
--     })
--   end,
-- })

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
