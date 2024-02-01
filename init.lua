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
--  'echasnovski/mini.files',
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
  'nvim-telescope/telescope-file-browser.nvim',
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
      'goolord/alpha-nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
          require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end
  },
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

local map = function(mode, l, r, opts)
  opts = opts or {}
  opts.silent = true
  vim.keymap.set(mode, l, r, opts)
end

local telescope = require("telescope.builtin")

require('mason').setup()

-- Colorschemes

require('rose-pine').setup({
  styles = {
    italic = false,
  },
  highlight_groups = {
    Comment = { italic = true },
    Constant = { bold = true },
    Boolean = {bold = true},
  }
})

vim.cmd 'colorscheme rose-pine'

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

-- Filesystem

-- Minifiles

--require('mini.files').setup()

--local files_set_cwd = function(path)
--  local cur_entry_path = MiniFiles.get_fs_entry().path
--  local cur_directory = vim.fs.dirname(cur_entry_path)
--  vim.fn.chdir(cur_directory)
--end
--
--vim.api.nvim_create_autocmd('User', {
--  pattern = 'MiniFilesBufferCreate',
--  callback = function(args)
--    vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id })
--  end,
--})

--vim.cmd 'nnoremap <leader>fe <cmd>lua MiniFiles.open()<cr>'

-- Telescope File Browser

vim.cmd 'nnoremap <leader>fe <cmd>Telescope file_browser<cr>'

local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format('%s %s', 'edit', j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
--  vim.cmd('Telescope file_browser')
end

--local select_and_reopen = function(prompt_bufnr)
--  require('telescope.actions').select_default(prompt_bufnr)
--  vim.cmd('Telescope file_browser')
--end

local fb_actions = require('telescope').extensions.file_browser.actions
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<S-CR>'] = select_one_or_multi,
	['J'] = require('telescope.actions').move_selection_next,
	['K'] = require('telescope.actions').move_selection_previous,
	['L'] = require('telescope.actions').toggle_selection,
	['R'] = fb_actions.rename,
	['M'] = fb_actions.move,
	['Y'] = fb_actions.copy,
	['D'] = fb_actions.remove
      },
      n = {
        ['<S-CR>'] = select_one_or_multi,
	['l'] = require('telescope.actions').toggle_selection
      }
    }
  }
}

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

--Greeter

local dashboard = require("alpha.themes.dashboard")

-- Set header
--dashboard.section.header.val = {
--"      ██████████            ██████████                       ",
--"     ██████████              ████████                        ", 
--"    ██████████████████ ███████████ ███  ██████████  ",
--"   █████████████████ ████████████ █████ ██████████████  ",
--"  ███████████████   ██████████████ █████ █████ ████ █████  ",
--" ██████████████████████████████████ █████ █████ ████ █████ ",
--"█████  ███ ██████████████████ ████ █████ █████ ████ ██████"
--}


dashboard.section.header.val = {
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⠀⠀⠁⠚⡴⣤⣀⠀⠀⠀⠀⡟⣴⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠟⡿⣶⣤⣀⠀⠿⣿⣴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠋⡿⣿⣾⣴⣡⠉⠞⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠿⣿⣿⣿⣶⣠⢀⠀⡴⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⠀⡀⣀⣤⣦⣶⣶⣶⣶⣶⣶⣴⣥⣿⣿⣿⣿⣿⣿⣿⣿⣴⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⠀⠉⠉⠉⡏⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⡀⣀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣩⢃⣿⣼⢀⠀⠀⠀⣠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⣄⣦⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣾⣠⠀⠀⣿⣴⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⡀⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⠿⠿⣿⣿⣿⣿⣿⣾⣶⣿⢹⣾⢠⠀⠀⠀⠀⠀⠀⠀⠀",
"⠁⠈⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⠀⠀⠀⠁⠟⣿⣿⡿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⡄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⠿⡿⣿⣿⣾⢀⠀⠀⠀⠁⠉⠈⠇⠻⠙⠋⡿⠻⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣹⠀⠀⠀⠁⠟⣿⣾⣤⣀⢀⠀⠀⠖⣤⣀⢀⠀⠁⣀⣤⣶⣶⣤⢀⠀⠀⠀",
"⠀⠀⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⣀⠀⠀⠀⣇⣿⣿⣿⣿⣀⢀⠀⠁⠟⣿⣿⣿⣿⣿⣿⢻⠉⠈⠀⠀⠀",
"⠀⠀⠃⣿⢹⠁⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣤⣁⠋⠛⠿⠿⠿⠛⠙⠀⠀⠀⡏⣿⣿⣿⣿⣿⣿⣶⣴⣤⣤⢀",
"⠀⠀⠀⠃⠸⠀⠁⡟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣴⣠⠀⠀⠀⠀⠀⠀⠀⡇⣿⣿⠙⠛⡿⣿⣿⣿⣿⣿⣾",
"⠀⠀⠀⠀⠀⠀⠀⠀⡟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣠⠀⠀⠀⠀⠀⠿⣿⣶⠤⠀⠀⠀⠀⠀⠀⠉",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⠀⠀⠀⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠀⠀⡀⣄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
"⠀⠀⠀⠀⠂⠒⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
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

map("n", "<c-l>", ":bn<CR>")
map("n", "<c-h>", ":bp<bn<CR>")
map("n", "<c-q>", ":bd<bn<CR>")

map("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
map("n", "<leader>t", ":enew<CR>")

map("n", "<leader>fo", telescope.oldfiles)
map("n", "<leader>ff", telescope.find_files)
map("n", "<leader>fg", telescope.live_grep)
map("n", "<leader>fb", telescope.buffers)
map("n", "<leader>fh", telescope.help_tags)

map("n", "<Esc>", "<Esc>:noh<return>")

map("n", "<c-j>", ":m .+1<cr>==")
map("n", "<c-k>", ":m .-2<cr>==")
map("i", "<c-j>", "<esc>:m .+1<cr>==gi")
map("i", "<c-k>", "<esc>:m .-2<cr>==gi")
map("v", "<c-j>", ":m '>+1<cr>gv=gv")
map("v", "<c-k>", ":m '<-2<cr>gv=gv")

vim.cmd "let g:python3_host_prog = '~/.venvs/debugpy/Scripts/python'"
