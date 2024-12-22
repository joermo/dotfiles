local M = {}

-- List contains helper
M.contains = function(list, value)
  for _, v in ipairs(list) do
    if v == value then
      return true
    end
  end
  return false
end

-- Copy the current file path and line number to the clipboard, use GitHub URL if in a Git repository
M.copyFilePathAndLineNumber = function()
  local current_file = vim.fn.expand("%:p")
  local current_line = vim.fn.line(".")
  local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")
  if is_git_repo then
    local current_repo = vim.fn.systemlist("git remote get-url origin")[1]
    local current_branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
    -- convert ssh to http
    if not string.find(current_repo, "http") then -- is ssh
      local git_host = string.match(current_repo, "^[^:]*")
      -- git_host = git_host:sub(1, -2) -- remove trailing :
      local cleaned_git_host = git_host:gsub("git@", "")
      current_repo = current_repo:gsub(git_host .. ":", "https://" .. cleaned_git_host .. "/")
    end
    current_repo = current_repo:gsub("%.git$", "")
    -- Remove leading system path to repository root
    local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if repo_root then
      current_file = current_file:sub(#repo_root + 2)
    end
    local url = string.format("%s/blob/%s/%s#L%s", current_repo, current_branch, current_file, current_line)
    vim.fn.setreg("+", url)
    vim.notify("Copied to clipboard: " .. url)
  else
    -- If not in a Git directory, copy the full file path
    vim.fn.setreg("+", current_file .. "#L" .. current_line)
    vim.notify("Copied full path to clipboard: " .. current_file .. "#L" .. current_line)
  end
end

-- Custom function to invoke conform formatting
M.conform_format = function()
  local conform = require("conform")
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end

-- Custom function to format by range via objects and motions
M.format_range_operator = function()
  local conform = require("conform")
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local opts = {
      range = {
        ["start"] = vim.api.nvim_buf_get_mark(0, "["),
        ["end"] = vim.api.nvim_buf_get_mark(0, "]"),
      },
    }
    conform.format(opts)
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil
  end
  vim.go.operatorfunc = "v:lua.op_func_formatting"
  vim.api.nvim_feedkeys("g@", "n", false)
end

M.close_all_buffers_but_current_and_provided = function(keep_types)
  local buffers = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(buffers) do
    local buf_type = vim.api.nvim_get_option_value("filetype", { buf = buf })
    local keep_buf = M.contains(keep_types, buf_type) or buf == current_buf
    if not keep_buf then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

M.get_buf_summary = function()
  local buf_info = {}
  buf_info.buffer_number = vim.api.nvim_get_current_buf()
  buf_info.name = vim.api.nvim_buf_get_name(buf_info.buffer_number)
  buf_info.filetype = vim.api.nvim_get_option_value("filetype", { buf = buf_info.buffer_number })
  buf_info.line_count = vim.api.nvim_buf_line_count(buf_info.buffer_number)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  buf_info.cursor_line = cursor_pos[1]
  buf_info.cursor_column = cursor_pos[2]
  buf_info.is_modified = vim.api.nvim_get_option_value("modified", { buf = buf_info.buffer_number })
  buf_info.is_readonly = vim.api.nvim_get_option_value("readonly", { buf = buf_info.buffer_number })
  return buf_info
end

M.print_buf_summary = function()
  local buf_info = M.get_buf_summary()
  print("Buffer Information:")
  print("  Buffer Number: " .. buf_info.buffer_number)
  print("  Name: " .. buf_info.name)
  print("  Filetype: " .. buf_info.filetype)
  print("  Line Count: " .. buf_info.line_count)
  print("  Cursor Position: Line " .. buf_info.cursor_line .. ", Column " .. buf_info.cursor_column)
  print("  Modified: " .. tostring(buf_info.is_modified))
  print("  Readonly: " .. tostring(buf_info.is_readonly))
end

M.get_current_visual_selection = function()
  return table.concat(vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos(".")), "\n")
end

M.neotree_get_current_selection = function()
  local state = require("neo-tree.sources.manager").get_state_for_window()
  local node = state.tree:get_node()
  local filepath = node:get_id()
  return filepath
end


M.neotree_get_closest_dir = function()
  local cur_file = M.neotree_get_current_selection()
  if vim.fn.isdirectory(cur_file) ~= 0 then
    return cur_file
  else
    return vim.fn.fnamemodify(cur_file, ":h") -- get parent of current file
  end
end

return M
