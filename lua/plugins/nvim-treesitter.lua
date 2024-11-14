local plugin = {'nvim-treesitter/nvim-treesitter'}

plugin.dependencies = {
  {'nvim-tree/nvim-web-devicons'}
}

function plugin.config()
  require("nvim-treesitter.configs").setup{
    highlight = {
      enable = true,
    },
    indent = {
      enable = false
    }
  }
end

return plugin
