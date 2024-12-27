local bind = vim.keymap.set
local custom_pickers = require("joermo.config.telescope.custom_pickers")

-- vim.ui.select = custom_pickers.select

-- ---------------------------

-- Fuzzy find files
bind({ "n", "v" }, "'s", function()
  custom_pickers.custom_workspace_grep("files", false, {})
end, { desc = "Search Workspace Files" })
bind({ "n", "v" }, "'S", function()
  custom_pickers.custom_workspace_grep("files", true, {})
end, { desc = "Search Workspace Files (Literal/No-grep)" })
bind("n", "'b", function()
  require("telescope.builtin").buffers({})
end, { desc = "Search Currently Open Buffers" })

-- Fuzzy searching
bind({ "n", "v" }, "'r", function()
  custom_pickers.custom_workspace_grep("grep", false, {})
end, { desc = "Live Grep Workspace" })
bind({ "n", "v" }, "'R", function()
  custom_pickers.custom_workspace_grep("grep", true, {})
end, { desc = "Live Search Wrokspace (Literal/No-grep)" })
bind("n", "'f", function()
  require("telescope.builtin").live_grep({ grep_open_files = true })
end, { desc = "Live Grep Open Files" })
bind("n", "'c", function()
  require("telescope.builtin").current_buffer_fuzzy_find({})
end, { desc = "Live Grep Current File" })

-- LSP Binds
bind("n", "<leader>O", function()
  require("telescope.builtin").lsp_workspace_symbols({})
end, { desc = "Show Workspace Symbols" })
bind("n", "<leader>o", function()
  local ft = vim.bo.filetype
  if ft ~= "yaml" then
    require("telescope.builtin").lsp_document_symbols({})
  else
    custom_pickers.yaml_symbols({})
  end
end, { desc = "Show Document Symbols" })
bind("n", "gd", function()
  require("telescope.builtin").lsp_definitions({ reuse_win = true })
end)
bind("n", "gi", function()
  require("telescope.builtin").lsp_implementations({ reuse_win = true })
end)
bind("n", "gr", function()
  require("telescope.builtin").lsp_references({ reuse_win = true })
end, { desc = "References" })
bind("n", "gt", function()
  require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
end)
-- Git
bind("n", "'gs", function()
  require("telescope.builtin").git_status({})
end, { desc = "Show Git Status" })

-- Misc
bind("n", "'km", function()
  require("telescope.builtin").keymaps({})
end, { desc = "Select From Telescope Builtins" })
bind("n", "'ts", function()
  require("telescope.builtin").builtin({})
end, { desc = "Select From Telescope Builtins" })

----------------------------------------------------------------------

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
  },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        mappings = {
          i = {
            ["<ESC>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
            ["<C-s>"] = actions.send_selected_to_qflist,
            ["<C-q>"] = actions.send_to_qflist,
          },
          n = {
            ["qq"] = actions.close,
            ["q"] = actions.close,
          },
        },
      },
      layout_config = {
        -- vertical = { width = 0.5 },
      },
      pickers = {
        find_files = {
          -- theme = "dropdown",
        },
      },
      file_ignore_patterns = {
        "./node_modules/*",
        "node_modules",
        "^node_modules/*",
        "node_modules/*",
        "*venv*",
      },
    }
  end,
}
