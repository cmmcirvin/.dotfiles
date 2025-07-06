local plugin = {'adigitoleo/haunt.nvim'}

function plugin.config()
  require("haunt").setup({
    window = {
      winblend = 0,
      border = "rounded"
    },
  })
  vim.keymap.set("n", "<leader>h", ":HauntHelp ")
end

return plugin
