-- Pulled from: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#fuzzy-search-among-yaml-objects

local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local finders = require("telescope.finders")

local M = {}

M.visit_yaml_node = function(node, name, yaml_path, result, file_path, bufnr)
  local key = ""
  if node:type() == "block_mapping_pair" then
    local field_key = node:field("key")[1]
    key = vim.treesitter.get_node_text(field_key, bufnr)
  end

  if key ~= nil and string.len(key) > 0 then
    table.insert(yaml_path, key)
    local line, col = node:start()
    table.insert(result, {
      lnum = line + 1,
      col = col + 1,
      bufnr = bufnr,
      filename = file_path,
      text = table.concat(yaml_path, "."),
    })
  end

  for node, name in node:iter_children() do
    M.visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
  end

  if key ~= nil and string.len(key) > 0 then
    table.remove(yaml_path, table.maxn(yaml_path))
  end
end

M.gen_from_yaml_nodes = function(opts)
  local entry_display = require("telescope.pickers.entry_display")
  local displayer = entry_display.create({
    separator = " │ ",
    items = {
      { width = 5 },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    return displayer({
      { entry.lnum, "TelescopeResultsSpecialComment" },
      {
        entry.text,
        function()
          return {}
        end,
      },
    })
  end

  return function(entry)
    local make_entry = require("telescope.make_entry")
    return make_entry.set_default_entry_mt({
      ordinal = entry.text,
      display = make_display,
      filename = entry.filename,
      lnum = entry.lnum,
      text = entry.text,
      col = entry.col,
    }, opts)
  end
end

M.yaml_symbols = function(opts)
  local yaml_path = {}
  local result = {}
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "ft")
  local tree = vim.treesitter.get_parser(bufnr, ft):parse()[1]
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local root = tree:root()
  for node, name in root:iter_children() do
    M.visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
  end

  -- return result
  pickers
    .new(opts, {
      prompt_title = "YAML symbols",
      finder = finders.new_table({
        results = result,
        entry_maker = opts.entry_maker or M.gen_from_yaml_nodes(opts),
      }),
      sorter = conf.generic_sorter(opts),
      previewer = conf.grep_previewer(opts),
    })
    :find()
end

return M
