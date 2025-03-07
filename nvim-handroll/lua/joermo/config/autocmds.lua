-- Add autocommand to show macro recording status below status line
vim.cmd([[ autocmd RecordingEnter * set cmdheight=1 ]])
vim.cmd([[ autocmd RecordingLeave * set cmdheight=0 ]])

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

-- Custom yank highlighting ----------------------------------------------------
-- local hl_bg_color = vim.fn.synIDattr(vim.fn.hlID("Visual"), "bg")
local hl_bg_color = "#6600FF"
local hl_fg_color = nil -- "#FFFFFF"
local hl_opts = {
  bg = hl_bg_color,
  fg = hl_fg_color
}
vim.api.nvim_set_hl(0, "YankHighlight", hl_opts)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  callback = function()
    vim.highlight.on_yank({
      higroup = "YankHighlight",
      timeout = 100,
    })
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

-- Add additional patterns for docker compose language server filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "docker-compose*.yml", "docker-compose*.yaml" },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
})


-- Set options for markdown
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.o.wrap = true
  end,
})


-- Snacks.nvim
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
      if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
      end
  end,
})
