local plugin = {"rose-pine/neovim"}

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
