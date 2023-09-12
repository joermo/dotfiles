vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })



-- Rose pine
--require('rose-pine').setup({
    --disable_background = true
--})

-- Monokai
require('monokai').setup { palette = require('monokai').pro }

-- -- Oxocarbon
-- vim.opt.background = "dark"
-- vim.cmd("colorscheme gruvbox")
