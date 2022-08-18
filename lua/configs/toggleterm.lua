local map = vim.api.nvim_set_keymap
local buf_map = vim.api.nvim_buf_set_keymap

require('toggleterm').setup({
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.32
    end
  end,
  open_mapping = '<C-n>',
  hide_numbers = true,
  shade_filetypes = {},
  highlights = {
    Normal = {
      guibg = require('configs.onedarkpro.colors').black,
    },
  },
  shade_terminals = false,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'vertical',
  close_on_exit = true,
  shell = vim.o.shell,
})
map('t', '<ESC>', '<C-\\><C-n>', { noremap = true, silent = true })

local set_terminal_keymaps = function()
  local opts = { noremap = true }
  buf_map(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  buf_map(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  buf_map(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  buf_map(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  buf_map(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = function()
    set_terminal_keymaps()
  end,
  desc = 'Mappings for navigation with a terminal',
})
