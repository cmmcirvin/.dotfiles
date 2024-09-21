local plugin = {"zbirenbaum/copilot-cmp"}

plugin.event = 'VeryLazy'

function plugin.config()
  require("copilot_cmp").setup({})
end

return plugin
