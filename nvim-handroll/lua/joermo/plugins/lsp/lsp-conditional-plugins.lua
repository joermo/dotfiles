local function add_conditional_spec(main_spec, single_spec, condition)
  if condition == "" or vim.fn.executable(condition) == 1 then
    table.insert(main_spec, single_spec)
  end
end

local plugin_specs = {}

-- Add rustaceanvim spec if cargo binary is on path
add_conditional_spec(plugin_specs, {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
}, "cargo")

return plugin_specs
