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

    -- Quick access with numbers
    bind("n", "'1", function() harpoon_safe_select(1) end, { desc="Switch to harpoon 1" })
    bind("n", "'2", function() harpoon_safe_select(2) end, { desc="Switch to harpoon 2" })
    bind("n", "'3", function() harpoon_safe_select(3) end, { desc="Switch to harpoon 3" })
    bind("n", "'4", function() harpoon_safe_select(4) end, { desc="Switch to harpoon 4" })

    -- Toggle previous & next buffers stored within Harpoon list
    bind({ "n" }, "<C-j>", function()harpoon:list():next({ ui_nav_wrap = true })end, { desc="Switch to previous harpooned file" })
    bind({ "n" }, "<C-k>", function()harpoon:list():prev({ ui_nav_wrap = true })end, { desc = "Switch to next harpooned file" })

    -- Manually set indices
    bind("n", "<leader>1", function() harpoon:list():replace_at(1) end, { desc="Set harpoon idx 1" })
    bind("n", "<leader>2", function() harpoon:list():replace_at(2) end, { desc="Set harpoon idx 2" })
    bind("n", "<leader>3", function() harpoon:list():replace_at(3) end, { desc="Set harpoon idx 3" })
    bind("n", "<leader>4", function() harpoon:list():replace_at(4) end, { desc="Set harpoon idx 4" })
    bind("n", "m1", function() harpoon:list():replace_at(1) end, { desc="Set harpoon idx 1" })
    bind("n", "m2", function() harpoon:list():replace_at(2) end, { desc="Set harpoon idx 2" })
    bind("n", "m3", function() harpoon:list():replace_at(3) end, { desc="Set harpoon idx 3" })
    bind("n", "m4", function() harpoon:list():replace_at(4) end, { desc="Set harpoon idx 4" })
  end
}
