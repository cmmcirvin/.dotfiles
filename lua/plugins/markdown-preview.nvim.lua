if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {'iamcco/markdown-preview.nvim'}

plugin.cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }
plugin.ft = { "markdown" }
plugin.build = "cd app && npm install"
plugin.init = function() vim.g.mkdp_filetypes = { "markdown" } end

function plugin.config()
  vim.keymap.set("n", "<c-p>", "<cmd>MarkdownPreviewToggle<CR>")
end

return plugin
