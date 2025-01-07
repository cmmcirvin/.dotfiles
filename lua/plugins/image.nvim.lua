if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {"3rd/image.nvim"}

function plugin.config()
  require("image").setup({
    backend = "kitty",
    max_width_window_percentage=100,
    max_height_window_percentage=100,
    integrations = {
      markdown = {
        enabled = false
      }
    },
  })
end

return plugin
