local plugin = {"okuuva/auto-save.nvim"}

plugin.event = { "InsertLeave", "TextChanged" }
function plugin.config()
  require("auto-save").setup({
    enabled = true,
  })
end

return plugin
