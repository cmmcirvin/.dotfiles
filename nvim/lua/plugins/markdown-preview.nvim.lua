if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {'iamcco/markdown-preview.nvim'}

plugin.cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }
plugin.ft = { "markdown" }
plugin.build = "cd app && npm install"
plugin.init = function() vim.g.mkdp_filetypes = { "markdown" } end

vim.g.mkdp_markdown_css = "/Users/cmcirvin/.config/nvim/css/markdown-preview.css"
vim.g.mkdp_preview_options = { disable_filename = 1 }

function plugin.config()
  vim.keymap.set("n", "<c-p>", "<cmd>MarkdownPreviewToggle<CR>")
end

return plugin
