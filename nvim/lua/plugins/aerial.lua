local plugin = {'stevearc/aerial.nvim'}

function plugin.config()
  require("aerial").setup({
    manage_folds = true,
    filter_knd = false,
      filter_kind = {
        "Class",
        "Constructor",
        "Function",
        "Method",
        "Module",
      },
    layout = {
      default_direction = "float",
      min_width = 0.6,
    },
    float = {
      border = "rounded",
      relative = "win",
      min_height = 0.8,
    },
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
    nav = {
      border = "rounded",
      win_opts = {
        cursorline=false,
        winblend=10,
      },
      min_height = 0.4,
      min_width = 0.6,
      preview = true,
      autojump = false,
      keymaps = {
        ["<ESC>"] = "actions.close",
        ["v"] = "actions.jump_vsplit",
        ["s"] = "actions.jump_split",
      },
    }
  })
  vim.keymap.set("n", "<leader>ae", "<cmd>AerialToggle<CR>")
  vim.keymap.set("n", "<leader>n", "<cmd>AerialNavToggle<CR>")
end

return plugin
