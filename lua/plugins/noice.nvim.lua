local plugin = {"folke/noice.nvim"}

plugin.dependencies = {
  {"muniftanjim/nui.nvim"}
}
plugin.event = "VeryLazy"

function plugin.config()
  require("noice").setup()
end

return plugin
