local plugin = {"mfussenegger/nvim-lint"}

function plugin.config()
  require("lint").linters_by_ft = {
    python = {'flake8', 'ruff', 'pylint'},
--    tex = {'chktex'}
  }

  vim.keymap.set('n', '<leader>fl', ':lua require("lint").try_lint()<CR>')
end

return plugin
