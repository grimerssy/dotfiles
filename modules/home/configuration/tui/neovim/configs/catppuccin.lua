require("catppuccin").setup({
  flavour = "macchiato",
  transparent_background = true,
  term_colors = true,
  styles = {
    comments = { "italic" },
    functions = { "italic" },
    keywords = { "italic" },
  },
  custom_highlights = function(colors)
    return {
      Macro = { fg = colors.sky },
      StorageClass = { fg = colors.mauve },
      CmpItemKindStruct = { fg = colors.yellow },
      CmpItemKindEnum = { fg = colors.yellow },
      CmpItemKindEnumMember = { fg = colors.peach },
      CmpItemKindInterface = { fg = colors.green },
      ["@function.builtin"] = { link = "Function" },
      ["@function.macro"] = { link = "Macro" },
      ["@lsp.typemod.macro.defaultLibrary"] = { link = "Macro" },
    }
  end,
  integrations = {
    notify = true,
    harpoon = true,
  },
})

vim.cmd.colorscheme("catppuccin")
