local plugin = {"zbirenbaum/copilot.lua"}

plugin.event = 'VeryLazy'

function plugin.config()
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false }
  })
end

return plugin
