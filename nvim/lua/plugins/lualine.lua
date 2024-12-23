local function get_recent_message()
  local cur_time = os.time() * 1000
  local elapsed_time = cur_time - _G.last_msg_time
  if _G.last_msg ~= nil and type(elapsed_time) == "number" and elapsed_time < 5000 then
    return _G.last_msg
  else
    return [[]]
  end
end

return {
  "nvim-lualine/lualine.nvim",
  -- opts = {
  --   sections = {
  --     lualine_x = { get_recent_message },
  --   },
  -- },
  opts = function(_, opts)
    table.insert(opts.sections.lualine_c, get_recent_message)
  end,
}
