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
          b = { fg=palette.foam, bg=palette.base },
          a = { fg=palette.foam, bg=palette.base },
          c = { bg=palette.base },
        },
        visual = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.foam, bg=palette.base },
          c = { bg=palette.base },
        },
        replace = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.foam, bg=palette.base },
          c = { bg=palette.base },
        },
        normal = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.gold, bg=palette.base },
          c = { bg=palette.base },
        },
        insert = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.foam, bg=palette.base },
          c = { bg=palette.base },
        },
        command = {
          a = { fg=palette.foam, bg=palette.base },
          b = { fg=palette.foam, bg=palette.base },
          c = { bg=palette.base },
        },
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = {
        {
          'buffers',
          use_mode_colors = true,
          show_modified_status = true,
          max_length = vim.o.columns,
        }
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'branch'},
    },
  })
end

return plugin
