local plugin = {"cmmcirvin/dispynvim"}

function plugin.config()
  vim.keymap.set({'n', 'v'}, '<leader>pi', ':lua require("dispynvim").display_single_image()<CR>')
  vim.keymap.set({'n', 'v'}, '<leader>pl', ':lua require("dispynvim").display_random_images(4)<CR>')
  vim.keymap.set({'n', 'v'}, '<leader>ps', ':lua require("dispynvim").plot_statistics()<CR>')
  vim.keymap.set({'n', 'v'}, '<leader>pt', ':lua require("dispynvim").print_statistics()<CR>')
end

return plugin
