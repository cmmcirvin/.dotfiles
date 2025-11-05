local plugin = {"echasnovski/mini.nvim"}

function plugin.config()
  require("mini.move").setup()
end

return plugin
