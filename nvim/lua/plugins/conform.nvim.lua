local plugin = {"stevearc/conform.nvim"}

function plugin.config()
  require("conform").setup({
    formatters_by_ft = {
      python = { "isort", "black" },
      json = { "jq" },
    }
  })

  vim.keymap.set('n', '<leader>fw', ':lua require("conform").format()<CR>')
end

return plugin
