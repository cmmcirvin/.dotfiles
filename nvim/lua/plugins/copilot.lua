if not os.getenv("IN_LOCAL_SHELL") or os.getenv("COPILOT_DISABLE") then
  return {}
end

local plugin = {"zbirenbaum/copilot.lua"}

plugin.event = 'VeryLazy'

function plugin.config()
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false }
  })
end

return plugin
