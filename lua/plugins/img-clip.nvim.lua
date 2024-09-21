local plugin = {"HakonHarnes/img-clip.nvim"}

function plugin.config()
  require("img-clip").setup({
  })

  vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>")
end

return plugin
