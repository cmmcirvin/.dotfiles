local plugin = {"folke/zen-mode.nvim"}

plugin.dependencies = {
  "folke/twilight.nvim",
}

function plugin.config()
  vim.keymap.set( "n", "<leader>z", function()
    require("zen-mode").toggle({
      window = {
        width = 0.95,
        height = 0.95,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        twilight = {
          enabled = true,
          dimming = {
            alpha = 0.25,
            color = { "Normal", "#ffffff" },
            inactive = false,
          },
        },
      }
    })
  end)
end

return plugin
