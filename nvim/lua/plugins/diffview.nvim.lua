local plugin = {'sindrets/diffview.nvim'}

function plugin.config()
  require("diffview").setup({
    vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>")
  })
end

return plugin
