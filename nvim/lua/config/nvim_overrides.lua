-- Override the functionality for vim api functions to store the passed message param and timestamp in global variables.
-- This helps pull messages to display in lualine for a set time interval.

local util = require("config.utils")

local include_levels = {
  vim.log.levels.TRACE,
  vim.log.levels.DEBUG,
  vim.log.levels.INFO,
  vim.log.levels.WARN,
  vim.log.levels.ERROR,
  vim.log.levels.OFF,
}

_G.last_msg = nil
_G.last_msg_time = nil

local function override_functions(parent_module, functions, custom_logic)
  local split_module = util.split_string(parent_module, ".")
  local original_functions = {}
  local module = _G[split_module[1]]
  for i = 2, #split_module do
    module = module[split_module[i]]
  end
  for _, func_name in ipairs(functions) do
    original_functions[func_name] = module[func_name]
    module[func_name] = function(...)
      custom_logic(...)
      original_functions[func_name](...)
    end
  end
end

local function store_message(message, level)
  if level == nil then
    level = vim.log.levels.WARN
  end
  if util.contains(include_levels, level) then
    _G.last_msg = message
    _G.last_msg_time = (os.time() * 1000)
  end
end

override_functions("vim", { "notify", "notify_once" }, store_message)

override_functions("vim.api", {
  "nvim_err_writeln",
  "nvim_err_write",
}, store_message)

-- --------------------------------------------------------------------------------------------------------------
-- -- Use a timer-based approach to conditionally set cmdheight when new messages are received.
-- local function set_cmdheight(height)
--   if height == nil then
--     height = 0
--   end
--   vim.o.cmdheight = height
-- end
--
-- local timer = nil
--
-- local function start_or_reset_timer(delay_ms)
--   if timer then
--     timer:stop()
--   end
--   timer = vim.loop.new_timer()
--   timer:start(delay_ms, 0, vim.schedule_wrap(set_cmdheight))
-- end
--
-- local original_notify = vim.notify
--
-- vim.notify = function(msg, level, opts)
--   set_cmdheight(1)
--   start_or_reset_timer(5000)
--   original_notify(msg, level, opts)
-- end
-- --------------------------------------------------------------------------------------------------------------
