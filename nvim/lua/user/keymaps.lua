vim.keymap.set("n", "<c-l>", ":bn!<CR>")
-- vim.keymap.set("n", "<Esc>", "<Esc>:noh<return>")
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set("n", "<c-h>", ":bp!<CR>")
vim.keymap.set("n", "<c-q>", ":bp<bar>bd! #<CR>")

vim.keymap.set("n", "<c-j>", ":m .+1<cr>==")
vim.keymap.set("n", "<c-k>", ":m .-2<cr>==")

vim.keymap.set("i", "<c-j>", "<esc>:m .+1<cr>==gi")
vim.keymap.set("i", "<c-k>", "<esc>:m .-2<cr>==gi")

vim.keymap.set("v", "<c-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<c-k>", ":m '<-2<cr>gv=gv")
