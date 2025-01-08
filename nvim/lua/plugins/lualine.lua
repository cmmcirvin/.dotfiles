local plugin = {"nvim-lualine/lualine.nvim"}

function plugin.config()
  require("lualine").setup({
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
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
