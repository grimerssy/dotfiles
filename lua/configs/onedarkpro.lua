local onedarkpro = require 'onedarkpro'

local colors = {
  bg = '#282C34',
  fg = '#A9B2C0',
  red = '#F16372',
  orange = '#DB975C',
  yellow = '#DAB067',
  green = '#8CC570',
  blue = '#40B0F5',
  cyan = '#00AEBA',
  purple = '#E36FEA',
  white = '#A9B2C0',
  black = '#23272E',
  gray = '#576270',
  highlight = '#2B323D',
  none = 'NONE',
}

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
  },
  hlgroups = {
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
    NvimTreeNormal = { bg = colors.black },
    NvimTreeWinSeparator = { fg = colors.blue, bg = colors.none },
    BufferCurrent = { fg = colors.blue, bg = colors.highlight },
    BufferCurrentMod = { fg = colors.blue, bg = colors.highlight },
    BufferVisible = { fg = colors.black },
  },
  filetype_hlgroups = {},
  plugins = {
    all = false,
    packer = true,
    telescope = true,
    treesitter = true,
    barbar = true,
  },
  styles = {
    strings = 'NONE',
    comments = 'NONE',
    keywords = 'NONE',
    functions = 'NONE',
    variables = 'NONE',
    virtual_text = 'NONE',
  },
  options = {
    bold = false,
    italic = false,
    underline = false,
    undercurl = false,
    cursorline = true,
    transparency = true,
    terminal_colors = true,
    window_unfocussed_color = false,
  }
})

