local plugin = {'adigitoleo/haunt.nvim'}

function plugin.config()
  require("haunt").setup({
    vim.keymap.set("n", "<leader>h", ":HauntHelp ")
  })
end

return plugin
