local plugin = {'nvim-treesitter/nvim-treesitter'}

plugin.dependencies = {
  {'nvim-tree/nvim-web-devicons'}
}

function plugin.config()
  local disabled_filetypes = {os.getenv("NVIM_TREESITTER_DISABLED")} or {}
  require("nvim-treesitter.configs").setup{
    highlight = {
      enable = true,
      disable = disabled_filetypes,
    },
    indent = {
      enable = false
    }
  }
end

return plugin
