-- Plugin managers
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'rose-pine/neovim',
  'rktjmp/lush.nvim',
  'Scysta/pink-panic.nvim',
  'echasnovski/mini.files',
  'pocco81/autosave.nvim',
  'ggandor/leap.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies =
    {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter'
    }
  },
  'dstein64/vim-startuptime',
  'williamboman/mason.nvim',
  'mfussenegger/nvim-dap',
  'mfussenegger/nvim-dap-python',
  'neogitorg/neogit',
  'mbbill/undotree',
  'ap/vim-css-color',
  'chentoast/marks.nvim',
  'nvim-lualine/lualine.nvim',
  {
    "folke/noice.nvim",
    opts={},
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      }
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = 
    {
      'nvim-tree/nvim-web-devicons'
    }
  },
  'rmagatti/goto-preview',
--  'sirver/ultisnips',
--  {
--    'hrsh7th/nvim-cmp',
--    dependencies = 
--    {
--      'quangnguyen30192/cmp-nvim-ultisnips'
--    }
--  },
--  'hrsh7th/cmp-buffer',
--  'hrsh7th/cmp-path',
--  'hrsh7th/cmp-nvim-lua',
--  'hrsh7th/cmp-nvim-lsp',
})

require('mason').setup()

-- Colorschemes

require('rose-pine').setup({
  styles = {
    italic = false
  },
  highlight_groups = {
    Comment = { italic = true },
    Constant = { bold = true },
    Boolean = {bold = true},
  }
})

--vim.cmd 'colorscheme rose-pine'
vim.cmd 'colorscheme pink-panic'

-- Navigation

-- Leap

leap = require('leap')
vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward-to)')
vim.keymap.set({'n', 'x', 'o'}, 'F', '<Plug>(leap-backward-to)')
vim.keymap.set({'n', 'x', 'o'}, 't', '<Plug>(leap-forward-till)')
vim.keymap.set({'n', 'x', 'o'}, 'T', '<Plug>(leap-backward-till)')
leap.opts.labels = {'e', 'r', 'g', 'v', 'c', 'n', 'm', 'u', 'b', 't', 'y', 's', 'f', 'd'}
leap.opts.safe_labels = {'e', 'r', 'g', 'v', 'c', 'n', 'm', 'u', 'b', 't', 'y', 's', 'f', 'd'}
leap.init_highlight(true)

-- MiniFiles

require('mini.files').setup()

local files_set_cwd = function(path)
  local cur_entry_path = MiniFiles.get_fs_entry().path
  local cur_directory = vim.fs.dirname(cur_entry_path)
  vim.fn.chdir(cur_directory)
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id })
  end,
})

-- Bufferline

require('bufferline').setup()

-- Lualine

require('lualine').setup ({
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  },
  sections = {
    lualine_c = 
    {
      {
  'filename',
        file_status = true,
        path = 1,
      }
    }
  }
})

-- Commands
vim.cmd 'nnoremap <leader>fe <cmd>lua MiniFiles.open()<cr>'
vim.cmd 'set nu'
vim.cmd 'set relativenumber'

-- Syntax

-- Treesitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  }
}

vim.cmd 'syntax enable'


-- Python Debugger
local dap = require('dap') 
dap.defaults.switchbuf = 'v'
dap.defaults.fallback.external_terminal = {
    command = '~/AppData/Local/Programs/Git/usr/bin/bash';
    args = {'-e'}
}

-- Autocomplete

-- Cmp

--local cmp = require('cmp')
--local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
--cmp.setup {
--    mapping = {
--	["<Tab>"] = cmp.mapping(
--          function(fallback)
--            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
--          end,
--          { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
--        ),
--        ["<S-Tab>"] = cmp.mapping(
--          function(fallback)
--            cmp_ultisnips_mappings.jump_backwards(fallback)
--          end,
--          { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
--        ),
--    },
--    sources = {
--	{ name = "gh_issues" },
--	{ name = "nvim_lua" },
--	{ name = "nvim_lsp" },
--	{ name = "path"},
--	{ name = "ultisnips" },
--	{ name = "buffer", keyword_length = 1},
--    },
--    snippet = {
--	expand = function(args)
--	    vim.fn["UltiSnips#Anon"](args.body)
--	end,
--    },
--}

-- UltiSnips

--vim.cmd "let g:UltiSnipsExpandTrigger = '<tab>'"
--vim.cmd "let g:UltiSnipsJumpForwardTrigger = '<tab>'"
--vim.cmd "let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'"

vim.opt.termguicolors = true

vim.cmd 'nnoremap <c-l> :bn<CR>'
vim.cmd 'nnoremap <c-h> :bp<CR>'
vim.cmd 'nnoremap <c-q> :bd<CR>'

vim.cmd 'nnoremap <leader>u <cmd>UndotreeToggle<cr>'
vim.cmd 'nnoremap <leader>t :enew<CR>'
vim.cmd 'nnoremap <leader>ff <cmd>lua require("telescope.builtin").find_files()<cr>'
vim.cmd 'nnoremap <leader>fg <cmd>lua require("telescope.builtin").live_grep()<cr>'
vim.cmd 'nnoremap <leader>fb <cmd>lua require("telescope.builtin").buffers()<cr>'
vim.cmd 'nnoremap <leader>fh <cmd>lua require("telescope.builtin").help_tags()<cr>'

vim.cmd 'nnoremap <Esc> <Esc>:noh<return>'

vim.cmd 'nnoremap <c-j> :m .+1<cr>=='
vim.cmd 'nnoremap <c-k> :m .-2<cr>=='
vim.cmd 'inoremap <c-j> <esc>:m .+1<cr>==gi'
vim.cmd 'inoremap <c-k> <esc>:m .-2<cr>==gi'
vim.cmd "vnoremap <c-j> :m '>+1<cr>gv=gv"
vim.cmd "vnoremap <c-k> :m '<-2<cr>gv=gv"

vim.cmd "let &shell='bash.exe'"
vim.cmd "let &shellcmdflag='-c'"

vim.cmd 'nnoremap <leader>o <cmd>browse oldfiles<cr>'

vim.cmd "let g:python3_host_prog = '~/.venvs/debugpy/Scripts/python'"
