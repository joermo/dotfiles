local M = {}

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
    print("Copied to clipboard: " .. url)
  else
    -- If not in a Git directory, copy the full file path
    vim.fn.setreg("+", current_file .. "#L" .. current_line)
    print("Copied full path to clipboard: " .. current_file .. "#L" .. current_line)
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

-- List contains helper
M.contains = function(list, value)
  for _, v in ipairs(list) do
    if v == value then
      return true
    end
  end
  return false
end

-- String split helper
M.split_string = function(str, delimiter)
  local result = {}
  for word in string.gmatch(str, "([^" .. delimiter .. "]+)") do
    table.insert(result, word)
  end
  return result
end

if not table.pack then
  table.pack = function(...)
    return { n = select("#", ...), ... }
  end
end

if not table.unpack then
  table.unpack = unpack
end

M.table_to_str = function(tbl)
  local result = {}
  -- Helper function to handle nested tables
  local function serialize(val)
    if type(val) == "table" then
      local subResult = {}
      for key, value in pairs(val) do
        local keyStr = type(key) == "string" and string.format("%q", key) or tostring(key)
        table.insert(subResult, keyStr .. " = " .. serialize(value))
      end
      return "{" .. table.concat(subResult, ", ") .. "}"
    elseif type(val) == "string" then
      return string.format("%q", val) -- Properly escape strings
    else
      return tostring(val)
    end
  end
  -- Start the table serialization
  for key, value in pairs(tbl) do
    local keyStr = type(key) == "string" and string.format("%q", key) or tostring(key)
    table.insert(result, keyStr .. " = " .. serialize(value))
  end
  return "{" .. table.concat(result, ", ") .. "}"
end

M.close_all_buffers_but_current_and_provided = function(keep_types)
  local buffers = vim.api.nvim_list_bufs()
  vim.notify("buffer is" .. buffers[1])
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(buffers) do
    -- local buf_type = vim.api.nvim_buf_get_option(buf, "filetype") or ""
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
  print("Buffer Information:")
  print("  Buffer Number: " .. buf_info.buffer_number)
  print("  Name: " .. buf_info.name)
  print("  Filetype: " .. buf_info.filetype)
  print("  Line Count: " .. buf_info.line_count)
  print("  Cursor Position: Line " .. buf_info.cursor_line .. ", Column " .. buf_info.cursor_column)
  print("  Modified: " .. tostring(buf_info.is_modified))
  print("  Readonly: " .. tostring(buf_info.is_readonly))
end

return M
