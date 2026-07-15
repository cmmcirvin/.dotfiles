local plugin = { 'MeanderingProgrammer/render-markdown.nvim' }

function plugin.config()
  require('render-markdown').setup({
    render_modes = { 'n', 'c', 't', 'i' },
    enabled = true,
    file_types = { "markdown", "Avante" },
    latex = {
      enabled = false,
      converter = 'latex2text',
    },
  })
end

return plugin
