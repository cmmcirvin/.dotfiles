local plugin = {'neovim/nvim-lspconfig'}

function plugin.config()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.config('ty', {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    root_markers = { 'ty.toml', 'pyproject.toml', '.git' },
    capabilities = capabilities
  })

  vim.lsp.enable('ty')

end

plugin.event = { "BufReadPre" }

return plugin
