if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {"cmmcirvin/dispy.nvim"}

function plugin.config()
  require("dispynvim").setup({
    n_images = 4,
    cell_aspect_ratio = 18 / 40,
    scale = 1.0,
  })
  vim.keymap.set({'n', 'v'}, '<leader>pi', ':lua require("dispynvim").display_single_image()<CR>')

  vim.keymap.set({'n', 'v'}, '<leader>pl', ':lua require("dispynvim").display_random_images(4)<CR>')
  vim.keymap.set({'n', 'v'}, '<leader>ps', ':lua require("dispynvim").plot_statistics()<CR>')
  vim.keymap.set({'n', 'v'}, '<leader>pt', ':lua require("dispynvim").print_statistics()<CR>')
end

return plugin
