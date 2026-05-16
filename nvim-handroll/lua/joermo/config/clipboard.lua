local is_ssh = vim.env.SSH_CLIENT ~= nil
  or vim.env.SSH_TTY ~= nil
  or vim.env.SSH_CONNECTION ~= nil
local clip_file = "/dev/shm/nvim-clipboard.txt"

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

local function set_ram_clipboard_for_ssh()
  local function write_clip(reg, lines)
    local text = table.concat(lines, "\n")
    vim.fn.writefile(vim.split(text, "\n", { plain = true }), clip_file)
    vim.fn.setfperm(clip_file, 'rw-------')
    local osc52 = require("vim.ui.clipboard.osc52")
    osc52.copy(reg)(lines)
  end
  local function read_clip()
    if vim.fn.filereadable(clip_file) == 0 then
      return { "" }
    end
    return vim.fn.readfile(clip_file)
  end
  vim.g.clipboard = {
    name = "ram-clipboard",
    copy = {
      ["+"] = function(lines)
        write_clip("+", lines)
      end,
      ["*"] = function(lines)
        write_clip("*", lines)
      end,
    },
    paste = {
      ["+"] = read_clip,
      ["*"] = read_clip,
    },
  }
end


if is_ssh then
  set_ram_clipboard_for_ssh()
else
  -- no override required
end
