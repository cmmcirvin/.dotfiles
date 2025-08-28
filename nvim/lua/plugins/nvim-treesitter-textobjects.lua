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
          ["a="] = "@assignment.outer",
          ["i="] = "@assignment.inner",
          ["l="] = "@assignment.lhs",
          ["r="] = "@assignment.rhs",
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
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@call.outer",
          ["]m"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]i"] = "@conditional.outer",
          ["]l"] = "@loop.outer",
          ["<c-p>"] = "@parameter.inner",
        },
        goto_next_end = {
          ["]F"] = "@call.outer",
          ["]M"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]I"] = "@conditional.outer",
          ["]L"] = "@loop.outer",
        },
        goto_previous_start = {
          ["[f"] = "@call.outer",
          ["[m"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[i"] = "@conditional.outer",
          ["[l"] = "@loop.outer",
          ["<c-o>"] = "@parameter.inner",
        },
        goto_previous_end = {
          ["[F"] = "@call.outer",
          ["[M"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[I"] = "@conditional.outer",
          ["[L"] = "@loop.outer",
        },
      },
      swap = {
        enable=true,
        swap_next = {
          ["<a-p>"] = "@parameter.inner",
        },
        swap_previous = {
          ["<a-o>"] = "@parameter.inner",
        },
      },
    },
  }
end

return plugin
