local plugin = {"mason-org/mason-lspconfig.nvim"}

plugin.dependencies = {
  "mason-org/mason.nvim",
  "neovim/nvim-lspconfig",
}

plugin.config = function()
  require("mason").setup()

  require("mason-lspconfig").setup({
    ensure_installed={
      "pyright",
      "clangd",
      "marksman",
    },
    automatic_installation=true,
    automatic_enable=false,
  })

end

return plugin
