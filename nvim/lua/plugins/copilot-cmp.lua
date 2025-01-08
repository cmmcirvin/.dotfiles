if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {"zbirenbaum/copilot-cmp"}

plugin.event = 'VeryLazy'

function plugin.config()
  require("copilot_cmp").setup({})
end

return plugin
