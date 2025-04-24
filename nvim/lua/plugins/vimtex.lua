if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {"lervag/vimtex"}

function plugin.init()
  vim.cmd "let g:vimtex_view_method = 'skim'"
  vim.cmd "let g:vimtex_quickfix_mode=0"
  vim.cmd "let g:vimtex_fold_enabled=0"
  vim.cmd "set conceallevel=2"
end

-- vim.api.nvim_exec([[
-- augroup VimtexConfig
--   autocmd!
--   autocmd TextChangedI *.tex silent! call vimtex#compiler#compile()
-- augroup END
-- ]], false)

plugin.lazy = false

return plugin
