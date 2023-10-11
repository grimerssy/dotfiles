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
      CursorLine = { bg = colors.none },
      ColorColumn = { bg = colors.none },
      NvimTreeGitNew = { fg = colors.green },
      NvimTreeSpecialFile = { fg = colors.sapphire },
    }
  end,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = true,
    treesitter = true,
  },
  integration = {
    dap = {
      enabled = true,
      enable_ui = true,
    },
  },
  native_lsp = {
    enabled = true,
    underlines = {
      errors = { "underline" },
      hints = { "underline" },
      warnings = { "underline" },
      information = { "underline" },
    },
  },
})