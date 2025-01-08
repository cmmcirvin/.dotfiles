local plugin = {'AckslD/nvim-trevj.lua'}

function plugin.config()
  require("trevj").setup(
    vim.keymap.set("n", "L", function()
      require('trevj').format_at_cursor()
    end)
  )
end

return plugin
