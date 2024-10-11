local plugin = {"mfussenegger/nvim-lint"}

function plugin.config()

  require("lint").linters_by_ft = {
    python = {"ruff"},
  }

  vim.keymap.set('n', '<leader>fl', ':lua require("lint").try_lint()<CR>')
end

return plugin
