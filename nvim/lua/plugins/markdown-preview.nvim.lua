if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = { "iamcco/markdown-preview.nvim" }

plugin.cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }
plugin.ft = { "markdown" }
plugin.build = function() vim.fn["mkdp#util#install"]() end

plugin.init = function()
  vim.g.mkdp_filetypes = { "markdown" }
end

vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/css/markdown-preview.css"
vim.g.mkdp_preview_options = {
  disable_filename = 1,
}

function plugin.config()
  vim.keymap.set("n", "<C-p>", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
end

return plugin
