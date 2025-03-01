vim.cmd "set list"
vim.cmd "set splitright"
vim.cmd "set nofixeol"
vim.cmd "set nofixendofline"
vim.cmd "set wfh"
vim.cmd "set wfw"
vim.cmd "set splitbelow"

vim.cmd "let g:mkdp_auto_close = 0"
vim.cmd "let g:mkdp_theme = 'light'"
vim.cmd "let g:vim_markdown_math = 1"

vim.cmd "syntax enable"

vim.cmd "tnoremap <Esc> <C-\\><C-n>"
vim.cmd "let g:python3_host_prog = '~/.venvs/debugpy/bin/python'"

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- 'K' again to jump into window
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.g.vimtex_enabled = 1
    vim.g.tex_flavor = 'latex'
  end,
})

vim.fn.sign_define('DapBreakpoint',{ text ='👀', texthl ='', linehl ='', numhl =''})

vim.keymap.set('n', '<leader>lo', function()
  vim.api.nvim_put({
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
    "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  }, 'l', true, true)
end)
