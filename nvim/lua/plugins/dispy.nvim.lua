local plugin = {"cmmcirvin/dispy.nvim"}

function plugin.config()
  require("dispynvim").setup({
    n_images = 4,
    cell_aspect_ratio = 18 / 40,
    scale = 1.0,
  })

  vim.keymap.set({'n', 'v'}, '<leader>px', ':lua require("dispynvim").plot({mode="plot_statistics"})<CR>')
  vim.keymap.set({'n', 'v'}, '<leader>ps', ':lua require("dispynvim").plot({mode="show_tensor"})<CR>')
end

return plugin
