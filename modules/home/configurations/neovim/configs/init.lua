local configs = {
  "loader",
  "options",
  "notify",

  "cmp",
  "lsp",
  "dap",
  "luasnip",
  "crates",

  "telescope",
  "treesitter",
  "comment",
  "harpoon",

  "icons",
  "oil",
  "lualine",
  "gitsigns",
  "dressing",
  "scrollbar",

  "remap",
  "yankhl",
}

for _, name in ipairs(configs) do
  require("configs." .. name)
end
