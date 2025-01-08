local plugin = {'williamboman/mason.nvim'}

plugin.depenencies = {
  {'williamboman/mason-lspconfig/nvim'}
}

function plugin.config()
  require("mason").setup()
end

return plugin
