vim.keymap.set("n", "<c-l>", "<cmd>bn!<CR>")
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set("n", "<c-h>", "<cmd>bp!<CR>")
vim.keymap.set("n", "<c-q>", "<cmd>bp<bar>bd! #<CR>")

vim.keymap.set("n", "<c-j>", "<cmd>m .+1<cr>==")
vim.keymap.set("n", "<c-k>", "<cmd>m .-2<cr>==")

vim.keymap.set("i", "<c-j>", "<esc>:m .+1<cr>==gi")
vim.keymap.set("i", "<c-k>", "<esc>:m .-2<cr>==gi")

vim.keymap.set("v", "<c-j>", "<cmd>m '>+1<cr>gv=gv")
vim.keymap.set("v", "<c-k>", "<cmd>m '<-2<cr>gv=gv")
