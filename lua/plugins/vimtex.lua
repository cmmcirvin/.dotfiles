local plugin = {"lervag/vimtex"}

function plugin.init()
  vim.cmd "let g:vimtex_view_method = 'skim'"
  vim.cmd "let g:tex_flavor='latex'"
  vim.cmd "let g:vimtex_view_skim_sync = 1"
  vim.cmd "let g:vimtex_view_skim_activate = 1"
  vim.cmd "let g:vimtex_quickfix_mode=0"
--  vim.cmd "let g:vimtex_compiler_latexmk = { 'options' : [ '-shell-escape' ] }"
  vim.cmd "let g:tex_conceal='abdmg'"
  vim.cmd "set conceallevel=1"
end

return plugin
