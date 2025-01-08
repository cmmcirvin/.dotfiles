local plugin = {"echasnovski/mini.nvim"}

function plugin.config()
  require("mini.move").setup()
  require("mini.animate").setup({
    cursor = { enable=true, timing=function(_, n) return 250 / n end, },
    scroll = { enable=false },
    resize = { enable=false },
    open = { enable=false },
    close = { enable=false },
  })
end

return plugin
