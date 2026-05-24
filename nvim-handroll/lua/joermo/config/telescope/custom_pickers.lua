local M = {}

M.yaml_symbols = require("joermo.config.telescope.yaml_object_picker").yaml_symbols
M.custom_workspace_grep = require("joermo.config.telescope.custom_multigrep").custom_workspace_grep
M.select = require("joermo.config.telescope.vim_ui_select").select

return M
