local M = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, {
    title = "yaml-objects-fzf",
  })
end

local function node_text(node, bufnr)
  if not node then return "" end
  return vim.treesitter.get_node_text(node, bufnr) or ""
end

local function strip_quotes(s)
  s = (s or ""):gsub("^%s+", ""):gsub("%s+$", "")
  if #s >= 2 then
    local a, b = s:sub(1, 1), s:sub(-1)
    if (a == '"' and b == '"') or (a == "'" and b == "'") then
      return s:sub(2, -2)
    end
  end
  return s
end

local function unwrap_flow_node(n)
  if not n then return nil end
  if n:type() ~= "flow_node" then return n end
  for c in n:iter_children() do
    return c
  end
  return n
end

local function split_pair(pair_node)
  local kids = {}

  for ch in pair_node:iter_children() do
    if ch:type() ~= ":" then
      kids[#kids + 1] = ch
    end
  end

  return unwrap_flow_node(kids[1]), unwrap_flow_node(kids[2])
end

-- 🔥 IMPORTANT: more correct YAML traversal entry point
local function get_root(parser)
  local tree = parser:parse()[1]
  if not tree then return nil end

  local root = tree:root()

  -- YAML trees often wrap content under document nodes
  for child in root:iter_children() do
    if child:type():find("mapping") or child:type():find("sequence") then
      return root
    end
  end

  return root
end

local function collect(bufnr)
  local ft = vim.bo[bufnr].filetype
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, ft)

  if not ok or not parser then
    return nil, "No Treesitter parser for: " .. ft
  end

  local tree = parser:parse()[1]
  if not tree then
    return nil, "No syntax tree"
  end

  local root = tree:root()
  local entries = {}

  local function add(path, node, anchor)
    local sr, sc = anchor:start()
    entries[#entries + 1] = {
      path = path,
      lnum = sr + 1,
      col = sc,
    }
  end

  local function walk(node, path)
    if not node then return end

    local t = node:type()

    if t == "block_mapping" or t == "flow_mapping" then
      for child in node:iter_children() do
        if child:type() == "block_mapping_pair"
        or child:type() == "flow_pair" then

          local k, v = split_pair(child)

          if k then
            local key = strip_quotes(node_text(k, bufnr))
            local newpath = (path ~= "" and (path .. "." .. key) or key)

            add(newpath, v, child)

            if v then
              walk(v, newpath)
            end
          end
        end
      end
      return
    end

    if t == "block_sequence" or t == "flow_sequence" then
      local idx = 0

      for child in node:iter_children() do
        local item = child

        if child:type() == "block_sequence_item" then
          item = nil
          for gc in child:iter_children() do
            item = unwrap_flow_node(gc)
            break
          end
        end

        item = unwrap_flow_node(item)

        if item then
          local newpath = ("%s[%d]"):format(path, idx)
          add(newpath, item, child)
          walk(item, newpath)
          idx = idx + 1
        end
      end
      return
    end

    for child in node:iter_children() do
      walk(child, path)
    end
  end

  walk(root, "")

  return entries
end

function M.yaml_objects(opts)
  opts = opts or {}

  local ok, fzf = pcall(require, "fzf-lua")
  if not ok then
    notify("fzf-lua missing", vim.log.levels.ERROR)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local entries, err = collect(bufnr)

  if not entries then
    notify(err, vim.log.levels.ERROR)
    return
  end

  if #entries == 0 then
    notify("No YAML paths found (collector empty)", vim.log.levels.ERROR)
    return
  end

  table.sort(entries, function(a, b)
    return a.path < b.path
  end)

  local fname = vim.api.nvim_buf_get_name(bufnr)

  local lines = {}

  -- IMPORTANT: encode real file positions for previewer
  for _, e in ipairs(entries) do
    lines[#lines + 1] = string.format(
      "%s:%d:%d:%s",
      fname,
      e.lnum,
      e.col,
      e.path
    )
  end

  fzf.fzf_exec(lines, {
    prompt = opts.prompt or "YAML> ",

    fzf_opts = {
      ["--delimiter"] = ":",
      ["--with-nth"] = "4",
      ["--preview-window"] = "right:60%",
    },

    -- 🔥 ONLY stable preview mode in fzf_exec
    previewer = "builtin",

    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then return end

        local parts = vim.split(selected[1], ":", { plain = true })

        vim.api.nvim_win_set_cursor(0, {
          tonumber(parts[2]) or 1,
          tonumber(parts[3]) or 0,
        })
      end,

      ["ctrl-y"] = function(selected)
        if not selected or #selected == 0 then return end

        local parts = vim.split(selected[1], ":", { plain = true })
        local path = parts[4]

        vim.fn.setreg("+", path)
        notify("Copied: " .. path)
      end,
    },
  })
end

return M
