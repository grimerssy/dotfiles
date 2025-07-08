-- TODO when move to stylix link HarpoonBorder to TelescopeBorder
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local map = vim.keymap.set

map("n", "<leader>m", mark.add_file)
map("n", "<leader>e", ui.toggle_quick_menu)

local function nav_file(file)
  return function()
    ui.nav_file(file)
  end
end

map("n", "<S-h>", nav_file(1))
map("n", "<S-j>", nav_file(2))
map("n", "<S-k>", nav_file(3))
map("n", "<S-l>", nav_file(4))
