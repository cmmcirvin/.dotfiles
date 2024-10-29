local plugin = {'nvim-treesitter/nvim-treesitter-textobjects'}

function plugin.config()
  require'nvim-treesitter.configs'.setup {
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
          ["as"] = "@statement.outer",
        },

        include_surrounding_whitespace = true,
      },
    },
  }
end

return plugin
