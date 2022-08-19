local onedarkpro = require('onedarkpro')

local colors = require('configs.onedarkpro.colors')

onedarkpro.setup({
  theme = function()
    if vim.o.background == 'dark' then
      return 'onedark'
    else
      return 'onelight'
    end
  end,
  colors = {
    bg = colors.bg,
    fg = colors.fg,
    red = colors.red,
    orange = colors.orange,
    yellow = colors.yellow,
    green = colors.green,
    cyan = colors.cyan,
    blue = colors.blue,
    purple = colors.purple,
    white = colors.white,
    black = colors.black,
    gray = colors.gray,
    highlight = colors.highlight,
    none = colors.none,
    cursorline = colors.highlight,
  },
  hlgroups = {
    Special = { fg = colors.cyan },
    SpecialChar = { link = 'Special' },

    CmpItemKindField = { fg = colors.orange },
    CmpItemKindInterface = { fg = colors.green },
    CmpItemKindModule = { fg = colors.cyan },
    CmpItemKindProperty = { fg = colors.orange },
    CmpItemKindSnippet = { fg = colors.fg },
    CmpItemKindEnumMember = { fg = colors.orange },
    CmpItemKindConstant = { fg = colors.orange },

    TSPunctBracket = { fg = colors.fg },
    TSOperator = { fg = colors.blue },
    TSFuncBuiltin = { fg = colors.blue },
    TSNamespace = { fg = colors.cyan },
    TSTypeBuiltin = { fg = colors.purple },
    TSType = { fg = colors.yellow },
    TSField = { fg = colors.orange },
    TSProperty = { fg = colors.orange },
    TSVariable = { fg = colors.orange },
    TSVariableBuiltin = { fg = colors.orange },
    TSParameter = { fg = colors.orange },
    TSParameterReference = { fg = colors.orange },
    TSCharacterSpecial = { link = 'Special' },

    NvimTreeNormal = { bg = colors.black },
    NvimTreeNormalNC = { link = 'NvimTreeNormal' },
    NvimTreeWinSeparator = { fg = colors.blue, bg = colors.none },
    NvimTreeFolderIcon = { fg = colors.blue },
    NvimTreeEmptyFolderName = { fg = colors.blue },
    NvimTreeOpenedFolderName = { fg = colors.blue },

    BufferCurrent = { fg = colors.blue, bg = colors.highlight },
    BufferCurrentMod = { link = 'BufferCurrent' },
    BufferCurrentTarget = { link = 'BufferCurrent' },
    BufferVisible = { fg = colors.fg, bg = colors.black },
    BufferVisibleIndex = { link = 'BufferVisible' },
    BufferVisibleMod = { link = 'BufferVisible' },
  },
  filetype_hlgroups = {},
  plugins = {
    all = false,
    packer = true,
    nvim_cmp = true,
    telescope = true,
    treesitter = true,
    nvim_tree = true,
    barbar = true,
  },
  styles = {
    strings = 'NONE',
    comments = 'NONE',
    keywords = 'italic',
    functions = 'NONE',
    variables = 'NONE',
    virtual_text = 'NONE',
  },
  options = {
    bold = true,
    italic = true,
    underline = true,
    undercurl = false,
    cursorline = true,
    transparency = true,
    terminal_colors = true,
    window_unfocussed_color = false,
  },
})
