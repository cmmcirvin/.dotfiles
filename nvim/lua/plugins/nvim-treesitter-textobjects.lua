local plugin = {'nvim-treesitter/nvim-treesitter-textobjects', branch="main"}

function plugin.config()
  require'nvim-treesitter-textobjects'.setup {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
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
        ["]l"] = "@loop.outer",
        ["<c-p>"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]F"] = "@call.outer",
        ["]M"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]L"] = "@loop.outer",
      },
      goto_previous_start = {
        ["[f"] = "@call.outer",
        ["[m"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[l"] = "@loop.outer",
        ["<c-o>"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[F"] = "@call.outer",
        ["[M"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[L"] = "@loop.outer",
      },
      goto_next = {
        ["]i"] = "@conditional.outer",
      },
      goto_previous = {
        ["[i"] = "@conditional.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<a-p>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<a-o>"] = "@parameter.inner",
      },
    },
  }
end

return plugin
