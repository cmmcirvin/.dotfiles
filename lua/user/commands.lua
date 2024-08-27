vim.cmd "set list"
vim.cmd "set nofixeol"
vim.cmd "set nofixendofline"
vim.cmd "set cursorline"

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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function(args)
    vim.lsp.start({
      name = 'pyright2',
      cmd = {'pyright'},
      -- root_dir = vim.fs.root(args.buf, {'setup.py', 'pyproject.toml'}),
    })
  end,
})
