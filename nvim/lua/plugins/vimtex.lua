if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {"lervag/vimtex", lazy = false}

function plugin.init()
  vim.cmd "let g:vimtex_view_method = 'skim'"
  vim.cmd "let g:vimtex_quickfix_mode=0"
  vim.cmd "let g:vimtex_fold_enabled=0"
  vim.cmd "set conceallevel=2"

end

return plugin
