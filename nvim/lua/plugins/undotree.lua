local plugin = {"mbbill/undotree"}

function plugin.config()
  vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
end

return plugin
