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

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local opts = { buffer = args.buf }

    -- Standard LSP keymaps
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    -- Custom hover with border and sizing options
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover({
        border = "rounded",
        max_width = math.floor(vim.o.columns * 0.75),
        max_height = math.floor(vim.o.lines * 0.4),
        wrap = true,
        wrap_at = math.floor(vim.o.columns * 0.7),
      })
    end, { buffer = args.buf, desc = "LSP Hover" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.g.vimtex_enabled = 1
    vim.g.tex_flavor = 'latex'
  end,
})


vim.keymap.set('n', '<leader>lo', function()
  vim.api.nvim_put({
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  }, 'l', true, true)
end)

vim.fn.sign_define('DapBreakpoint',{ text ='👀', texthl ='', linehl ='', numhl =''})

vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      ERROR = "‼",
      WARN = "⁈",
      INFO = "ℹ",
      HINT = "⁇",
    }
  },
  underline = true,
  update_in_insert = false
})

-- Custom floating window with better formatting
local function fancy_diagnostics()
  local opts = {
    focusable = true,
    border = 'rounded',
    source = 'always',
    prefix = function(diagnostic, i, total)
      local icons = {
        [vim.diagnostic.severity.ERROR] = "‼",
        [vim.diagnostic.severity.WARN] = "⁈",
        [vim.diagnostic.severity.INFO] = "ℹ",
        [vim.diagnostic.severity.HINT] = "⁇",
      }
      local icon = icons[diagnostic.severity] or "●"
      return i .. ". " .. icon .. " "
    end,
    suffix = function(diagnostic)
      return " (" .. vim.diagnostic.severity[diagnostic.severity]:lower() .. ")"
    end,
  }
  vim.diagnostic.open_float(nil, opts)
end

vim.keymap.set('n', 'gl', fancy_diagnostics, { 
  desc = "🔍 Show fancy diagnostics",
  silent = true 
})
