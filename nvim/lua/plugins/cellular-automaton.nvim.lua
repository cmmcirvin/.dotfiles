local plugin = {'Eandrju/cellular-automaton.nvim'}

function plugin.config()
  vim.keymap.set("n", "<leader>cam", "<cmd>CellularAutomaton make_it_rain<cr>")
  vim.keymap.set("n", "<leader>cag", "<cmd>CellularAutomaton game_of_life<cr>")
end

return plugin
