local n = require('keymap').nnoremap
local i = require('keymap').inoremap
local v = require('keymap').vnoremap
local x = require('keymap').xnoremap

n('<leader>so', '<CMD>luafile %<CR>')
n('<C-r', '<CMD>redo<CR>')
n('<C-h>', '<C-w>h')
n('<C-j>', '<C-w>j')
n('<C-k>', '<C-w>k')
n('<C-l>', '<C-w>l')
n('<C-d>', '<C-d>zz')
n('<C-u>', '<C-u>zz')
n('n', 'nzzzv')
n('N', 'Nzzzv')
n('<C-j>', 'cnext<CR>zz')
n('<C-k>', 'cprev<CR>zz')
n('<leader>n', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
-- to work with lsp remaps
n('<leader>rn', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

i('jk', '<ESC>')

v('jk', '<ESC>')
v('<', '<gv')
v('>', '>gv')

x('jk', '<ESC>')
x('<leader>p', '"_dP')
