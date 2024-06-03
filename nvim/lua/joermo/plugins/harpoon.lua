return {
  "ThePrimeagen/harpoon",
  lazy = false,
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function ()
    -- safely call harpoon select necessary because trying to select while no-name buffer is open will index into empty list
    local function harpoon_safe_select(idx_no)
      local harpoon = require('harpoon')
      pcall(function ()
        harpoon:list():select(idx_no)
      end)
    end

    local bind = vim.keymap.set
    local harpoon = require('harpoon')
    bind("n", "<leader>m", function() harpoon:list():add() end, { desc="Mark file for harpoon" })
    bind("n", "<leader>'", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc="Toggle harpoon menu" }) -- same function
    bind("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc="Toggle harpoon menu" }) -- same function

    -- Quick access
    bind("n", "<C-h>", function() harpoon_safe_select(1) end, { desc="Switch to harpoon 1" })
    bind("n", "<C-j>", function() harpoon_safe_select(2) end, { desc="Switch to harpoon 2" })
    bind("n", "<C-k>", function() harpoon_safe_select(3) end, { desc="Switch to harpoon 3" })
    bind("n", "<C-l>", function() harpoon_safe_select(4) end, { desc="Switch to harpoon 4" })

    -- Quick access with numbers
    bind("n", "'1", function() harpoon_safe_select(1) end, { desc="Switch to harpoon 1" })
    bind("n", "'2", function() harpoon_safe_select(2) end, { desc="Switch to harpoon 2" })
    bind("n", "'3", function() harpoon_safe_select(3) end, { desc="Switch to harpoon 3" })
    bind("n", "'4", function() harpoon_safe_select(4) end, { desc="Switch to harpoon 4" })

    -- Toggle previous & next buffers stored within Harpoon list
    bind("n", "<C-S-P>", function() harpoon:list():prev() end, { desc="Switch to next harpooned file" })
    bind("n", "<C-S-N>", function() harpoon:list():next() end, { desc="Switch to previous harpooned file" })
  end
}
