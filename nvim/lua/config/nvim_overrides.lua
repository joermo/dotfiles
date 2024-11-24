-- Override the functionality for vim.notify to store the last message and last message time.
-- This helps pull messages to display in lualine for a set time interval.

local original_notify = vim.notify

_G.last_msg = nil
_G.last_msg_time = nil

vim.notify = function(msg, level, opts)
  _G.last_msg = msg
  _G.last_msg_time = (os.time() * 1000)
  original_notify(msg, level, opts)
end

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
