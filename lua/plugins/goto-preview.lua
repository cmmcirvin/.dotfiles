-- TODO: Plugin settings are a work in progress
local plugin = {"rmagatti/goto-preview"}

plugin.event = "BufEnter"

function plugin.config()
  require("goto-preview").setup({
    default_mappings = true,
  })

  vim.keymap.set("n", "gpc", "<cmd>lua require('goto-preview').close_all_win()<CR>")
end

return plugin
