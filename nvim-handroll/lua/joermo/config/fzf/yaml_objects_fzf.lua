local M = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "yaml-objects-fzf" })
end

local function node_text(node, bufnr)
  return vim.treesitter.get_node_text(node, bufnr) or ""
end

local function strip_quotes(s)
  s = (s or ""):gsub("^%s+", ""):gsub("%s+$", "")
  if #s >= 2 and ((s:sub(1, 1) == '"' and s:sub(-1) == '"') or (s:sub(1, 1) == "'" and s:sub(-1) == "'")) then
    return s:sub(2, -2)
  end
  return s
end

local function is_scalar_type(t)
  return t:find("scalar") ~= nil
end

local function unwrap_flow_node(n)
  if not n then return nil end
  if n:type() ~= "flow_node" then return n end
  for c in n:iter_children() do
    return c
  end
  return n
end

local function count_mapping_pairs(map_node)
  local n = 0
  for ch in map_node:iter_children() do
    local t = ch:type()
    if t == "block_mapping_pair" or t == "flow_pair" then n = n + 1 end
  end
  return n
end

local function count_sequence_items(seq_node)
  local n = 0
  for ch in seq_node:iter_children() do
    local t = ch:type()
    if t == "block_sequence_item" then
      n = n + 1
    else
      -- flow_sequence items can be direct flow_nodes/scalars/mappings
      if t == "flow_node" or t:find("mapping") or t:find("sequence") or is_scalar_type(t) then
        n = n + 1
      end
    end
  end
  return n
end

local function preview_for_value(val_node, bufnr)
  if not val_node then return "null" end
  local t = val_node:type()
  if is_scalar_type(t) then
    local txt = strip_quotes(node_text(val_node, bufnr)):gsub("\n", " ")
    return txt
  end
  if t == "block_sequence" or t == "flow_sequence" then
    return ("<list:%d>"):format(count_sequence_items(val_node))
  end
  if t == "block_mapping" or t == "flow_mapping" then
    return ("<object:%d>"):format(count_mapping_pairs(val_node))
  end
  return ("<%s>"):format(t)
end

-- Robustly split a mapping pair into key-node and value-node using byte ranges.
local function split_pair(pair_node)
  local key_node, val_node
  -- Collect "substantial" direct children in source order.
  local kids = {}
  for ch in pair_node:iter_children() do
    local t = ch:type()
    if t ~= ":" then
      kids[#kids + 1] = ch
    end
  end
  if #kids == 0 then return nil, nil end
  -- Key is first substantial child.
  key_node = unwrap_flow_node(kids[1])
  -- Value is the first substantial child that starts after the key ends.
  local _, _, key_end_byte = key_node:range()
  for i = 2, #kids do
    local c = unwrap_flow_node(kids[i])
    local _, _, c_end_byte, c_start_byte -- nope
  end
  -- Tree-sitter range(): (start_row, start_col, end_row, end_col)
  local k_sr, k_sc, k_er, k_ec = key_node:range()
  for i = 2, #kids do
    local c = unwrap_flow_node(kids[i])
    local c_sr, c_sc = c:range()
    if (c_sr > k_er) or (c_sr == k_er and c_sc >= k_ec) then
      val_node = c
      break
    end
  end
  -- Fallback: last substantial child
  if not val_node and #kids >= 2 then
    val_node = unwrap_flow_node(kids[#kids])
    if val_node == key_node then val_node = nil end
  end
  return key_node, val_node
end

local function collect_entries(bufnr)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "yaml")
  if not ok or not parser then
    return nil, "Tree-sitter YAML parser not available (install :TSInstall yaml)"
  end
  local tree = parser:parse()[1]
  if not tree then return nil, "No syntax tree" end
  local root = tree:root()
  local entries = {}
  local function add(path, valnode, anchor_node)
    local sr, sc = anchor_node:start()
    entries[#entries + 1] = {
      path = path,
      preview = preview_for_value(valnode, bufnr),
      lnum = sr + 1,
      col = sc,
    }
  end
  local function walk(node, path)
    local t = node:type()
    if t == "block_mapping" or t == "flow_mapping" then
      for child in node:iter_children() do
        local ct = child:type()
        if ct == "block_mapping_pair" or ct == "flow_pair" then
          local k_node, v_node = split_pair(child)
          if k_node then
            local key = strip_quotes(node_text(k_node, bufnr))
            local newpath = (path ~= "" and (path .. "." .. key) or key)
            add(newpath, v_node, child)
            if v_node then walk(v_node, newpath) end
          end
        end
      end
      return
    end
    if t == "block_sequence" or t == "flow_sequence" then
      local idx = 0
      for child in node:iter_children() do
        local ct = child:type()
        if ct == "block_sequence_item" then
          local item = nil
          for gc in child:iter_children() do
            item = unwrap_flow_node(gc)
            break
          end
          local newpath = ("%s[%d]"):format(path, idx)
          add(newpath, item, child)
          if item then walk(item, newpath) end
          idx = idx + 1
        elseif ct == "flow_node" or ct:find("mapping") or ct:find("sequence") or is_scalar_type(ct) then
          local item = unwrap_flow_node(child)
          local newpath = ("%s[%d]"):format(path, idx)
          add(newpath, item, child)
          walk(item, newpath)
          idx = idx + 1
        end
      end
      return
    end
    if t == "flow_node" then
      local inner = unwrap_flow_node(node)
      if inner and inner ~= node then walk(inner, path) end
      return
    end
    for ch in node:iter_children() do
      walk(ch, path)
    end
  end
  walk(root, "")
  if #entries == 0 then
    return nil, "No YAML paths found"
  end
  return entries
end

function M.yaml_objects(opts)
  opts = opts or {}
  local fzf = require("fzf-lua")
  local bufnr = vim.api.nvim_get_current_buf()
  local entries, err = collect_entries(bufnr)
  if not entries then
    notify(err, vim.log.levels.ERROR)
    return
  end
  table.sort(entries, function(a, b) return a.path < b.path end)
  local lines = {}
  for _, e in ipairs(entries) do
    lines[#lines + 1] = ("%s\t%s\t%d\t%d"):format(e.path, e.preview, e.lnum, e.col)
  end
  fzf.fzf_exec(lines, {
    prompt = opts.prompt or "YAML> ",
    fzf_opts = {
      ["--delimiter"] = "\t",
      ["--with-nth"] = "1,2",   -- show path + preview
      ["--nth"] = "1..",
    },
    preview = opts.preview or "printf '%s\n\n%s\n' {1} {2}",
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then return end
        local fields = vim.split(selected[1], "\t", { plain = true })
        local lnum = tonumber(fields[3]) or 1
        local col = tonumber(fields[4]) or 0
        vim.api.nvim_win_set_cursor(0, { lnum, col })
      end,
      ["ctrl-y"] = function(selected)
        if not selected or #selected == 0 then return end
        local path = selected[1]:match("^(.-)\t") or selected[1]
        vim.fn.setreg("+", path)
        notify("Copied: " .. path)
      end,
    },
  })
end

return M
