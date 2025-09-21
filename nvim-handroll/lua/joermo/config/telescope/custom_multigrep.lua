local M = {}

M.live_multigrep = function(opts)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local make_entry = require("telescope.make_entry")
  local conf = require("telescope.config").values
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end
      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end
      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end
      return vim.tbl_flatten({
        args,
        -- { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
        opts.additional_args or {},
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })
  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Multi Grep",
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

M.custom_workspace_grep = function(search_type, match_literal, add_opts)
  local telescope = require("telescope.builtin")
  local utils = require("joermo.config.utils")
  local cur_mode = vim.api.nvim_get_mode()["mode"]
  local cur_ft = utils.get_buf_summary().filetype
  local opts = add_opts or {}
  if cur_ft == "neo-tree" then
    local search_dir = utils.neotree_get_closest_dir()
    opts.cwd = search_dir
  end
  if match_literal then -- add support to searching for literals instead of pattern
    opts.additional_args = { "--fixed-strings" }
  end
  local behavior_per_mode = {
    ["n"] = function()
      -- update if necessary
    end,
    ["v"] = function()
      opts.default_text = utils.get_current_visual_selection():gsub("\n", "")
    end,
  }
  behavior_per_mode[cur_mode]()
  if search_type == "files" then
    telescope.find_files(opts)
  else
    M.live_multigrep(opts)
  end
end

return M
