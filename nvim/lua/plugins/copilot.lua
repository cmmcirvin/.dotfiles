local plugin = {"zbirenbaum/copilot.lua"}

function plugin.config()
  require("copilot").setup({
    cmd = "Copilot",
    event = "InsertEnter",
  })
end

return plugin
