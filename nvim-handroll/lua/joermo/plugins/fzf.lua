local KEYMAPS = function ()
  -- May also call vim.bind manually/explicitly here for custom autocmds etc.
  -- TODO: revisit lazy.nvim 'keys' spec
  CUSTOM_PICKERS = require("joermo.config.fzf.custom_pickers")
  local literal_grep_opts = {
    ["grep_opts"] = "--fixed-strings",
    ["rg_opts"] = "--fixed-strings",
  }
  local cur_sel = UTILS.get_current_visual_selection
  return {
    -- Normal mode bindings
    ["n"] = {
      { "gd", function () FzfLua.lsp_definitions() end, "LSP definitions" },
      { "gr", function () FzfLua.lsp_references() end, "LSP references" },
      { "gp", function () FzfLua.lsp_typedefs() end, "GOTO parent def" },
      { "'s", function () FzfLua.files() end, "Find files" },
      { "'r", function () FzfLua.live_grep_native() end, "Live grep workspace" },
      { "'R", function () FzfLua.live_grep(literal_grep_opts) end, "Live grep workspace" },
      { "'b", function () FzfLua.buffers() end, "Open buffers" },
      { "'c", function () FzfLua.lgrep_curbuf() end, "Live grep current buffer" },
      { "qF", function () FzfLua.quickfix() end, "Open quickfix list" },
      { "<leader>O", function () FzfLua.lsp_workspace_symbols() end, "LSP symbols for current file" },
      { "<leader>o", function ()
        local ft = vim.bo.filetype
        if ft ~= "yaml" then
          FzfLua.lsp_document_symbols()
        else
          CUSTOM_PICKERS.yaml_objects()
        end
      end, "LSP symbols for current file"
      },
    },
    ["v"] = {
      { "'s", function () FzfLua.files({query=cur_sel()}) end, "Find file visual selection" },
      { "'r", function () FzfLua.live_grep_native({query=cur_sel()}) end, "Live grep visual selection" },
      { "'c", function () FzfLua.lgrep_curbuf({query=cur_sel()}) end, "Live grep current file visual selection" },
    },
    ["t"] = {}
  }
end

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostic disable: missing-fields
  opts = {},
  -- ---@diagnostic enable: missing-fields
  config = function ()
    local fzf = require("fzf-lua")
    TO_KEYBINDS(KEYMAPS())
    -- -- Override
    -- local orig_file_sel_to_qf = fzf.actions.file_sel_to_qf
    -- fzf.actions.file_sel_to_qf = function (selected, opts)
    --   opts = opts or {}
    --   opts['copen'] = false
    --   orig_file_sel_to_qf(selected, opts)
    -- end
    fzf.setup({
      -- profile = {"telescope", "hide"},
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
    })
    -- return {}
  end
}
