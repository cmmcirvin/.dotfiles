local plugin = {"kylechui/nvim-surround"}

plugin.event = 'VeryLazy'

function plugin.config()
  require("nvim-surround").setup({})
end

return plugin
