local plugin = {"stevearc/conform.nvim"}

function plugin.config()
  require("conform").setup({
    formatters_by_ft = {
      python = { "isort", "black", "ruff_fix", "fix8", "unify", "pybetter"}
    }
  })

  vim.keymap.set('n', '<leader>fw', ':lua require("conform").format()<CR>')
end

return plugin
