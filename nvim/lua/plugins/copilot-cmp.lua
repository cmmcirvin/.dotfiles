local plugin = { "zbirenbaum/copilot-cmp" }

plugin.config = function ()
  require("copilot_cmp").setup()
end

return plugin

