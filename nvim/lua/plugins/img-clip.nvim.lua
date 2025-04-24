if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {"HakonHarnes/img-clip.nvim"}

function plugin.config()
  require("img-clip").setup({
    default = {
      use_absolute_path=true
    }
  })

  vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>")
end

return plugin
