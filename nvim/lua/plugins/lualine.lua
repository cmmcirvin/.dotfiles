local plugin = {"nvim-lualine/lualine.nvim"}

print()

function plugin.config()
  palette = require("rose-pine.palette")

  require("lualine").setup({
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      theme = {
        inactive = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.foam, bg=palette.base },
          c = { bg=nil },
        },
        visual = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.foam, bg=palette.base },
          c = { bg=nil },
        },
        replace = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.foam, bg=palette.base },
          c = { bg=nil },
        },
        normal = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.gold, bg=palette.base },
          c = { bg=nil },
        },
        insert = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.foam, bg=palette.base },
          c = { bg=nil },
        },
        command = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.foam, bg=palette.base },
          c = { bg=nil },
        },
      }
    },
    tabline = {
      lualine_a = {
        {
          'branch'
        }
      },
      lualine_b = {
        {
          'buffers',
          use_mode_colors = true,
          max_length = vim.o.columns,
        }
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z ={},
    },
    sections = {}
  })
end

return plugin
