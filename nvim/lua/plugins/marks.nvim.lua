local plugin = {"chentoast/marks.nvim"}

function plugin.config()
  require("marks").setup({
    force_write_shada = true
  })
end

return plugin
