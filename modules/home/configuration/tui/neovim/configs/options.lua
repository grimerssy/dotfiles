vim.g.mapleader = " "

local options = {
  exrc = true,
  swapfile = false,
  undofile = true,
  timeoutlen = 500,
  expandtab = true,
  smartcase = true,
  smartindent = true,
  fileencoding = "utf-8",
  clipboard = "unnamedplus",

  wrap = false,
  cmdheight = 1,
  pumheight = 15,
  showmode = false,
  number = true,
  relativenumber = true,
  signcolumn = "yes",
  cursorline = true,
  cursorlineopt = "number",
  termguicolors = true,
  hlsearch = false,
  incsearch = true,
  scrolloff = 8,
  sidescrolloff = 5,
  splitbelow = true,
  splitright = true,

  tabstop = 4,
  shiftwidth = 4,
}

for k, v in pairs(options) do
  vim.o[k] = v
end
