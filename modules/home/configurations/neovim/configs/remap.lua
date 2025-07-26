local map = vim.keymap.set

map("i", "jk", [[<ESC>]])

map("n", "<C-r>", [[:redo<CR>]])
map("n", "<C-d>", [[<C-d>zzzv]])
map("n", "<C-u>", [[<C-u>zzzv]])
map("n", "n", [[nzzzv]])
map("n", "N", [[Nzzzv]])
map("n", "<C-j>", [[cnext<CR>zz]])
map("n", "<C-k>", [[cprev<CR>zz]])
map("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

map("v", "<", [[<gv]])
map("v", ">", [[>gv]])

map("x", "<leader>p", [["_dP]])
