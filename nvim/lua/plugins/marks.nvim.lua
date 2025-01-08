local plugin = {"chentoast/marks.nvim"}

function plugin.config()
  require("marks").setup()
end

return plugin
