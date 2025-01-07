local plugin = {'neovim/nvim-lspconfig'}

function plugin.config()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig = require("lspconfig")
  lspconfig.pyright.setup {
    capabilities = capabilities
  }
  lspconfig.clangd.setup {
    capabilities = capabilities
  }

end

plugin.event = { "BufReadPre" }

return plugin
