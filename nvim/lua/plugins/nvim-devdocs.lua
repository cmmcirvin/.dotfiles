if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {"luckasRanarison/nvim-devdocs"}

function plugin.config()
  vim.keymap.set("n", "<leader>dd", ":DevdocsOpenFloat<CR>")

  require("nvim-devdocs").setup({
    float_win = {
      relative = "editor",
      height = vim.api.nvim_win_get_height(0) - 20,
      width = vim.api.nvim_win_get_width(0) - 20,
      border = "rounded",
    },
    previewer_cmd = nil,
    wrap = true,
  })
end

return plugin
