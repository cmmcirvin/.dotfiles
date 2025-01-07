local plugin = {"amitds1997/remote-nvim.nvim"}

plugin.version="*"

plugin.dependencies = {
  "nvim-lua/plenary.nvim", -- For standard functions
  "MunifTanjim/nui.nvim", -- To build the plugin UI
  "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
}

plugin.config = true

return plugin
