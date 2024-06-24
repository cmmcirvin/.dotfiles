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
  'stevearc/aerial.nvim',
  'sindrets/diffview.nvim',
--  'folke/trouble.nvim',
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  'pocco81/autosave.nvim',
  'lervag/vimtex',
  'rmagatti/auto-session',
  'luckasRanarison/nvim-devdocs',
  'ggandor/leap.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies =
    {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter'
    }
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end
  },
  'nvim-telescope/telescope-file-browser.nvim',
  'dstein64/vim-startuptime',
  'williamboman/mason.nvim',
  'neovim/nvim-lspconfig',
  'williamboman/mason-lspconfig.nvim',
  'mfussenegger/nvim-dap',
  'mfussenegger/nvim-dap-python',
  'neogitorg/neogit',
  'sindrets/diffview.nvim',
  'mbbill/undotree',
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
--      "rcarriga/nvim-notify",
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
  'sirver/ultisnips',
  {
    'hrsh7th/nvim-cmp',
    dependencies = 
    {
      'quangnguyen30192/cmp-nvim-ultisnips'
    }
  },
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp',
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
    transparency = true,
  },
  highlight_groups = {
    Comment = { italic = true },
    Constant = { bold = true },
    Boolean = {bold = true},
  }
})

vim.cmd 'colorscheme rose-pine-moon'

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

-- Telescope File Browser

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
end

local fb_actions = require('telescope').extensions.file_browser.actions
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<S-CR>'] = select_one_or_multi,
      },
      n = {
        ['<S-CR>'] = select_one_or_multi,
        ['l'] = require('telescope.actions').toggle_selection
      }
    }
  }
}

-- Session manager

require("auto-session").setup({
    auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/" },
    auto_session_create_enabled = false,
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
vim.cmd 'set nu'
vim.cmd 'set relativenumber'

-- Syntax

-- Treesitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = false
  }
}

vim.cmd 'syntax enable'


-- Python Debugger
local dap = require('dap') 
dap.defaults.switchbuf = 'v'

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
    justMyCode = false,
    request = 'launch',
    console='integratedTerminal',
    name = 'Base working directory',
    program = '${file}',
    cwd = './'
})
table.insert(require('dap').configurations.python, {
    type = 'python',
    justMyCode = false,
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

--Greeter

local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"      ███ █████████████████    █████████████████████  ",
"     ███                ████   █  █                       █ ", 
"    ████████     █████████████████████████",
"   ███████████████████████████████████████",
"  ████████     ████████████████████████ ",
" ████ ███     ██  ██████████████████████  ",
"████   ████████ ████████ ████████████████████   ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
"                                                                      ",
}                                                                      
                                                                       
dashboard.section.buttons.val = {
    dashboard.button("o", "   > Recent" , ":Telescope oldfiles<cr>"),
    dashboard.button("f", "   > Find file", ":Telescope find_files<cr>"),
    dashboard.button("e", "   > Explorer", ":Telescope file_browser<cr>"),
    dashboard.button("g", "   > Grep"   , ":Telescope live_grep<cr>"),
    dashboard.button("b", "   > Buffers" , ":Telescope buffers<cr>"),
    dashboard.button("h", "   > Help", ":Telescope help_tags<cr>")
}

local cmp = require('cmp')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup {
    sources = {
        { name = "codeium" },
    },
    mapping = {
          ["J"] = cmp.mapping(
              function(fallback)
                cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
              end,
              { "i", "s" }
            ),
        ["K"] = cmp.mapping(
              function(fallback)
                cmp_ultisnips_mappings.jump_backwards(fallback)
              end,
              { "i", "s" }
            ),
        ['L'] = cmp.mapping.scroll_docs(-4),
        ['H'] = cmp.mapping.scroll_docs(4),
        ['<leader>c'] = cmp.mapping.confirm({ select = true }),
        ['<leader>e'] = cmp.mapping.abort(),
    },
    sources = {
        { name = "gh_issues" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "ultisnips" },
        { name = "codeium" },
        { name = "buffer", keyword_length = 1},
    },
    snippet = {
    expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
    end,
    },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').pyright.setup {
  capabilities = capabilities,
}

-- Aerial

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "[", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "]", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- UltiSnips

--vim.cmd "let g:UltiSnipsExpandTrigger = '<tab>'"
--vim.cmd "let g:UltiSnipsJumpForwardTrigger = '<tab>'"
--vim.cmd "let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'"

-- Git

-- Neogit

require('neogit').setup({
    integrations = { diffview = true }
})

vim.opt.termguicolors = true

map("n", "<c-l>", ":bn!<CR>")
map("n", "<c-h>", ":bp!<CR>")
map("n", "<c-q>", ":bp<bar>bd! #<CR>")

map("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
map("n", "<leader>t", ":enew<CR>")

map("n", "<leader>fo", telescope.oldfiles)
map("n", "<leader>ff", telescope.find_files)
map("n", "<leader>fg", telescope.live_grep)
map("n", "<leader>fb", telescope.buffers)
map("n", "<leader>fh", telescope.help_tags)
map("n", "<leader>fe", "<cmd>Telescope file_browser<cr>")
map("n", "<leader>fc", "<cmd>Telescope file_browser path=%:p:h<cr>")

map("n", "<Esc>", "<Esc>:noh<return>")

map("n", "<c-j>", ":m .+1<cr>==")
map("n", "<c-k>", ":m .-2<cr>==")
map("i", "<c-j>", "<esc>:m .+1<cr>==gi")
map("i", "<c-k>", "<esc>:m .-2<cr>==gi")
map("v", "<c-j>", ":m '>+1<cr>gv=gv")
map("v", "<c-k>", ":m '<-2<cr>gv=gv")

-- Trouble
--map("n", "<leader>xx", function() require("trouble").toggle() end)
--map("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
--map("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
--map("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
--map("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
--map("n", "gR", function() require("trouble").toggle("lsp_references") end)

map("n", "<leader>ss", "<cmd>SessionSave<cr>")

vim.cmd "let g:python3_host_prog = '~/.venvs/debugpy/bin/python'"

vim.cmd "set expandtab shiftwidth=4 softtabstop=4 tabstop=4"

vim.opt.fillchars = { eob = ' ' }

-- Documentation

require("nvim-devdocs").setup({
  float_win = {
    relative = "editor",
    height = vim.api.nvim_win_get_height(0) - 20,
    width = vim.api.nvim_win_get_width(0) - 20,
    border = "rounded",
  },
  previewer_cmd = "glow",
  cmd_args = { "-s", "dracula", "-w", vim.api.nvim_win_get_width(0) - 20 }
})

map("n", "<leader>dd", ":DevdocsOpenFloat<CR>")

-- lsp-config

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

vim.cmd 'nnoremap <Esc> <Esc>:noh<return>'
--vim.cmd 'nnoremap <c-q> :bp<bar>bd #<CR>'

vim.cmd 'set list'
vim.cmd 'set lcs+=space:·'

vim.cmd "let g:vimtex_view_method = 'skim'"
vim.cmd "let g:tex_flavor='latex'"
vim.cmd "let g:vimtex_view_skim_sync = 1"
vim.cmd "let g:vimtex_view_skim_activate = 1"
vim.cmd "let g:vimtex_quickfix_mode=0"
vim.cmd "let g:tex_conceal='abdmg'"
vim.cmd "set conceallevel=1"
vim.cmd "set foldmethod=expr"
vim.cmd "set foldexpr=nvim_treesitter#foldexpr()"
vim.cmd "set nofoldenable"
map("n", "<space>", "za")
map("v", "<space>", "zf")

vim.cmd "set cursorline"

vim.cmd 'tnoremap <Esc> <C-\\><C-n>'
