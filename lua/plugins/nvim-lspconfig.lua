local plugin = {'neovim/nvim-lspconfig'}

function plugin.config()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require("lspconfig").pyright.setup {
    capabilities = capabilities
  }
end

plugin.event = { "BufReadPre" }

return plugin
