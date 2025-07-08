local telescope = require("telescope")
local actions = require("telescope.actions")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")

local map = vim.keymap.set

map("n", "<leader>f", builtin.find_files)
map("n", "<leader>g", builtin.live_grep)
map("n", "<leader>h", builtin.diagnostics)

telescope.setup({
  defaults = vim.tbl_extend("force", themes.get_dropdown(), {
    path_display = { "truncate" },
    mappings = {
      n = {
        ["jk"] = actions.close,
      },
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-s>"] = actions.select_horizontal,
      },
    },
    file_ignore_patterns = {
      ".git/",
      ".direnv/",
      "build/",
      "target/",
      "node_modules/",
    },
  }),
  pickers = {
    find_files = {
      hidden = true,
      previewer = false,
    },
  },
})
