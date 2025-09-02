local plugin = { 'MeanderingProgrammer/render-markdown.nvim' }

function plugin.config()
  require('render-markdown').setup({
    enabled = true,
    file_types = { "markdown", "Avante" },
    latex = {
      enabled = true,
      converter = 'latex2text',
    },
  })
end

return plugin
