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
      enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-m>",
        node_incremental = "<c-m>",
        scope_incremental = false,
        node_decremental = "<c-n>",
      },
    },
  }
end

return plugin
