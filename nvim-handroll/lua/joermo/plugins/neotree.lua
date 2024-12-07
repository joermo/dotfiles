local bind = vim.keymap.set

-- bind("n", "<C-n>", vim.cmd.NvimTreeToggle, { desc = "Toggle file tree" })
-- bind("n", "tf", vim.cmd.NvimTreeFindFile, { desc = "Reveal current file in file tree" })
bind("n", "<C-n>", "<CMD>Neotree toggle<CR>", { desc = "Toggle file tree" })
bind("n", "tf", "<CMD>Neotree reveal<CR>", { desc = "Reveal current file in file tree" })


return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
      hide_gitignored = false,
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        visible = true,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true,
        hide_by_name = {
          "node_modules",
        },
      },
    },
    view = {
      adaptive_size = true,
    },
    window = {
      mappings = {
        -- Custom mapping to copy the name/path of the current file by selection.
        ["Y"] = function(state)
          -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
          -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local results = {
            filepath,
            modify(filepath, ":."),
            modify(filepath, ":~"),
            filename,
            modify(filename, ":r"),
            modify(filename, ":e"),
          }

          vim.ui.select({
            "1. Absolute path: " .. results[1],
            "2. Path relative to CWD: " .. results[2],
            "3. Path relative to HOME: " .. results[3],
            "4. Filename: " .. results[4],
            "5. Filename without extension: " .. results[5],
            "6. Extension of the filename: " .. results[6],
          }, { prompt = "Choose to copy to clipboard:" }, function(choice)
            local i = tonumber(choice:sub(1, 1))
            local result = results[i]
            vim.fn.setreg("+", result)
            vim.notify("Copied: " .. result)
          end)
        end,
      },
    },
  },
}
