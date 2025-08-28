local plugin = {'neovim/nvim-lspconfig'}

function plugin.config()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require("lspconfig")

  lspconfig.pyright.setup({
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          autoImportCompletions = true,
          diagnosticMode = "workspace",
        }
      }
    }
  })
  lspconfig.clangd.setup({capabilities = capabilities})

end

plugin.event = { "BufReadPre" }

return plugin
