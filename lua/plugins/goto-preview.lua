-- TODO: Plugin settings are a work in progress
local plugin = {"rmagatti/goto-preview"}

plugin.event = "BufEnter"
plugin.config = true

function plugin.config()
  require("goto-preview").setup()
end

return plugin
