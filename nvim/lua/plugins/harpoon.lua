-- Harpoon — ThePrimeagen's pinned-file jump tool.
-- Workflow: <leader>a to "pin" the current file, then <M-1>..<M-4> to jump
-- straight to pinned slot 1-4. <C-e> opens the pin list to see/edit order.
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>a", function() require("harpoon"):list():add() end,     desc = "Harpoon: add file" },
    { "<leader>A", function() require("harpoon"):list():prepend() end, desc = "Harpoon: prepend file" },
    {
      "<C-e>",
      function()
        local h = require("harpoon")
        h.ui:toggle_quick_menu(h:list())
      end,
      desc = "Harpoon: toggle menu",
    },
    { "<M-1>", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
    { "<M-2>", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
    { "<M-3>", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
    { "<M-4>", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
  },
  config = function()
    require("harpoon"):setup()
  end,
}
