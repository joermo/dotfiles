local M = {}

M.select = function(items, opts, on_choice)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = opts.prompt or "Select",
      finder = finders.new_table({
        results = items,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        -- Define what happens when an item is selected
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            on_choice(selection.value)
          end
        end)
        return true
      end,
    })
    :find()
end

return M
