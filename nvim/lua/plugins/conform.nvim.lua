local plugin = {"stevearc/conform.nvim"}

function plugin.config()
  require("conform").setup({
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      json = { "jq" },
      lua = { "stylua" },
    }
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.py", "*.json" },
    callback = function()
      require("conform").format()
    end,
  })
end

return plugin
