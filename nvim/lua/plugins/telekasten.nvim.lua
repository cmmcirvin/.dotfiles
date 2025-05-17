local plugin = {"nvim-telekasten/telekasten.nvim"}

function plugin.config()
  require("telekasten").setup({
    home = vim.fn.expand("~/zettelkasten"),
    templates = vim.fn.expand("~/zettelkasten/templates"),
    take_over_my_home = false,
  })

  vim.keymap.set("n", "zn", "<cmd>Telekasten new_templated_note<cr>", { desc = "New Telekasten note" })
  vim.keymap.set("n", "zp", "<cmd>Telekasten panel<cr>", { desc = "Open Telekasten panel" })
  vim.keymap.set("n", "zf", "<cmd>Telekasten find_notes<cr>", { desc = "Find Telekasten notes" })
  vim.keymap.set("n", "zl", "<cmd>Telekasten insert_link<cr>", { desc = "Insert Telekasten link" })
  vim.keymap.set("n", "zk", "<cmd>Telekasten follow_link<cr>", { desc = "Follow Telekasten link" })
  vim.keymap.set("n", "zy", "<cmd>Telekasten yank_notelink<cr>", { desc = "Yank Telekasten link to current note" })
  vim.keymap.set("n", "zb", "<cmd>Telekasten show_backlinks<cr>", { desc = "Show backlinks to current note" })
end

return plugin
