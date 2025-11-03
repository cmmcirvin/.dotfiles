local plugin = {'sindrets/diffview.nvim'}

function plugin.config()
  require("diffview").setup()

  vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>")
  vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>")
end

return plugin
