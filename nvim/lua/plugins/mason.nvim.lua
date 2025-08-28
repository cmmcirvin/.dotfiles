local plugin = {"mason-org/mason.nvim"}

plugin.config = function()
  require("mason").setup()
end

return plugin
