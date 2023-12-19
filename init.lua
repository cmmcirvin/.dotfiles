local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate"
  }
  use {'catppuccin/nvim', as='catppuccin'}
  use {'rose-pine/neovim', as='rose-pine'}
  use {'folke/tokyonight.nvim', as='tokyonight'}
  use {'nyoom-engineering/oxocarbon.nvim', as='oxocarbon'}
  use {'rebelot/kanagawa.nvim', as='kanagawa'}
  use {
    'nvim-lualine/lualine.nvim',
    requires={ 'nvim-tree/nvim-web-devicons', opt=True}
  }
  use({
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
        require("nvim-surround").setup()
    end
  })
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use 'rmagatti/goto-preview'
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }
  use 'pocco81/autosave.nvim'
  use({
    "pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup {}
    end,
  })
  use 'ggandor/leap.nvim'
  use 'lervag/vimtex'
  use 'tmhedberg/simpylfold'
  use 'burntsushi/ripgrep'
  use 'chentoast/marks.nvim'
  use 'echasnovski/mini.files'
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "quangnguyen30192/cmp-nvim-ultisnips",
      config = function()
        require("cmp_nvim_ultisnips").setup{}
      end,
      requires = { "nvim-treesitter/nvim-treesitter" },
    },
  })
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'folke/trouble.nvim'
  use 'neovim/nvim-lspconfig'
  use 'sirver/ultisnips'
  use 'mfussenegger/nvim-lint'
  use 'akinsho/bufferline.nvim'
  use 'neogitorg/neogit'
  use 'mbbill/undotree'
  use ({
    'lalitmee/browse.nvim',
    requires= { 'nvim-telescope/telescope.nvim',
                'nvim-lua/plenary.nvim'
    },
  })
  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }
end)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("mason").setup()
require("nvim-treesitter.configs").setup({
	highlight={
		enable=true,
		disable={"latex"}
	},
})

require('lualine').setup ({
    options = {
         section_separators = { left = '', right = '' },
	 component_separators = { left = '', right = '' },
    },
    sections = {
	lualine_c = {
	    {
		'filename',
		file_status = true,
		path = 1,
	    }
	}
    }
})
require('bufferline').setup()

require('goto-preview').setup({default_mappings = true})

require('neogit').setup()

require('telescope').setup({
    defaults = {
	layout_config = {
	    vertical = { width = 0.5 }
	},
    },
})

vim.diagnostic.config({
	virtual_text=false,
	virtual_lines=false
})

local cmp = require('cmp')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup {
    mapping = {
	["<Tab>"] = cmp.mapping(
          function(fallback)
            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
          end,
          { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
        ["<S-Tab>"] = cmp.mapping(
          function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
          end,
          { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
	['<leader><CR>'] = cmp.mapping.confirm({ select = true })
    },
    sources = {
	{ name = "gh_issues" },
	{ name = "nvim_lua" },
	{ name = "nvim_lsp" },
	{ name = "path"},
	{ name = "ultisnips" },
	{ name = "buffer", keyword_length = 1},
	{ name = "copilot"},
    },
    snippet = {
	expand = function(args)
	    vim.fn["UltiSnips#Anon"](args.body)
	end,
    },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').pyright.setup {
    capabilities = (function()
		     local capabilities = vim.lsp.protocol.make_client_capabilities()
		     capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
		     return capabilities
		   end)()
}

require'lspconfig'.ruff_lsp.setup {
    capabilities = capabilities
}

--require('lint').linters_by_ft = {
--  python = {'pylint',}
--}

require('marks').setup()
require('mini.files').setup()

-- Set up colorscheme
--vim.cmd 'colorscheme catppuccin-mocha'
vim.cmd 'colorscheme rose-pine'
--vim.cmd 'colorscheme tokyonight-moon'
--vim.cmd 'colorscheme oxocarbon'
--vim.cmd 'colorscheme kanagawa'
vim.cmd 'set nu'

--vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--    callback = function()
--        require("lint").try_lint()
--    end,
--})

-- Python Debugger
local dap = require('dap') 
dap.defaults.switchbuf = 'v'
dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/bash';
    args = {'-e'}
}

--require('rust-tools').setup()

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F8>', function() dap.close() end)
vim.keymap.set('n', '<F9>', function() dap.step_into() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end)

require('dap-python').setup('~/.venvs/debugpy/bin/python')
table.insert(require('dap').configurations.python, {
	type = 'python',
	request = 'launch',
	console='integratedTerminal',
	name = 'Base working directory',
	program = '${file}',
	cwd = './'
})
table.insert(require('dap').configurations.python, {
	type = 'python',
	request = 'launch',
	console='integratedTerminal',
	name = 'Base working directory with arguments',
	program = '${file}',
	cwd = './',
      	args = function()
      	  local args_string = vim.fn.input('Arguments: ')
      	  return vim.split(args_string, " +")
      	end;
})

-- Browser
local browse = require('browse')

function command(name, rhs, opts)
    opts = opts or {}
    vim.api.nvim_create_user_command(name, rhs, opts)
end

command("Chr", function()
    browse.input_search()
end, {})

command("Docs", function()
    browse.devdocs.search()
end, {})

local files_set_cwd = function(path)
  -- Works only if cursor is on the valid file system entry
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

leap = require('leap')
vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward-to)')
vim.keymap.set({'n', 'x', 'o'}, 'F', '<Plug>(leap-backward-to)')
vim.keymap.set({'n', 'x', 'o'}, 't', '<Plug>(leap-forward-till)')
vim.keymap.set({'n', 'x', 'o'}, 'T', '<Plug>(leap-backward-till)')
leap.opts.labels = {'e', 'r', 'g', 'v', 'c', 'n', 'm', 'u', 'b', 't', 'y', 's', 'f', 'd'}
leap.opts.safe_labels = {'e', 'r', 'g', 'v', 'c', 'n', 'm', 'u', 'b', 't', 'y', 's', 'f', 'd'}
leap.init_highlight(true)

--vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'

--vim.cmd "let g:vimtex_view_method = 'zathura'"
vim.cmd "let g:tex_flavor='latex'"
vim.cmd "let g:vimtex_view_method = 'skim'"
vim.cmd "let g:vimtex_view_skim_sync = 1"
vim.cmd "let g:vimtex_view_skim_activate = 1"
vim.cmd "let g:vimtex_quickfix_mode=0"
vim.cmd "set conceallevel=1"
vim.cmd "let g:tex_conceal='abdmg'"

vim.cmd "let g:UltiSnipsExpandTrigger = '<tab>'"
vim.cmd "let g:UltiSnipsJumpForwardTrigger = '<tab>'"
vim.cmd "let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'"

vim.cmd 'nnoremap <c-j> :m .+1<cr>=='
vim.cmd 'nnoremap <c-k> :m .-2<cr>=='
vim.cmd 'inoremap <c-j> <esc>:m .+1<cr>==gi'
vim.cmd 'inoremap <c-k> <esc>:m .-2<cr>==gi'
vim.cmd "vnoremap <c-j> :m '>+1<cr>gv=gv"
vim.cmd "vnoremap <c-k> :m '<-2<cr>gv=gv"

vim.cmd "let g:python3_host_prog = '~/.venvs/debugpy/bin/python'"
--vim.cmd 'set shellxquote='
--vim.cmd 'set shiftwidth=4'
--vim.cmd 'let $TMP="/tmp"'

vim.cmd 'tnoremap <Esc> <C-\\><C-n>'
vim.cmd 'set relativenumber'
vim.cmd 'set noexpandtab'
vim.cmd 'hi LineNr guifg=#838bb8'

--vim.cmd 'nnoremap zat :!/opt/homebrew/bin/zathura %:r.pdf &<cr>'
vim.cmd 'nnoremap <Space> za'

vim.cmd 'nnoremap gb :ls<CR>:b<Space>'
vim.cmd 'nnoremap <c-l> :bn<CR>'
vim.cmd 'nnoremap <c-h> :bp<CR>'
vim.cmd 'nnoremap <c-q> :bn<bar>:bd#<CR>'

vim.cmd 'nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>'

vim.cmd 'nnoremap <leader>u <cmd>UndotreeToggle<cr>'
vim.cmd 'nnoremap <leader>xf <cmd>lua vim.lsp.buf.code_action()<cr>'
vim.cmd 'nnoremap <leader>t :enew<CR>'
vim.cmd "nnoremap <leader>a :lua require'alpha'.start()<CR>"
vim.cmd 'nnoremap <leader>fe <cmd>lua MiniFiles.open()<cr>'
vim.cmd 'nnoremap <leader>ff <cmd>lua require("telescope.builtin").find_files()<cr>'
vim.cmd 'nnoremap <leader>fg <cmd>lua require("telescope.builtin").live_grep()<cr>'
vim.cmd 'nnoremap <leader>fb <cmd>lua require("telescope.builtin").buffers()<cr>'
vim.cmd 'nnoremap <leader>fh <cmd>lua require("telescope.builtin").help_tags()<cr>'

vim.cmd 'nnoremap <leader>xx <cmd>TroubleToggle<cr>'
vim.cmd 'nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>'
vim.cmd 'nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>'
vim.cmd 'nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>'
vim.cmd 'nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>'
vim.cmd 'nnoremap gr <cmd>TroubleToggle lsp_references<cr>'
vim.cmd 'nnoremap <leader>za :TZAtaraxis<CR>'

vim.cmd 'nnoremap <Esc> <Esc>:noh<return>'
