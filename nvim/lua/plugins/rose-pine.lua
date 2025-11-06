local plugin = {
  "rose-pine/neovim",
  lazy=false,
  priority=1001
}

function plugin.config()
  require("rose-pine").setup({
   styles = {
      italic = false,
      transparency = false,
    },
    highlight_groups = {
      Comment = { italic = true },
      Constant = { bold = true },
      Boolean = {bold = true},
    }
  })
end

return plugin
