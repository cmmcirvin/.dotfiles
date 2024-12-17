local plugin = {"mfussenegger/nvim-dap"}

plugin.dependencies = {
  {"mfussenegger/nvim-dap-python"}
}

function plugin.config()
  local dap = require('dap')
  dap.defaults.switchbuf = 'v'

--  dap.defaults.fallback.terminal_win_cmd = "lua vim.api.nvim_open_win(vim.api.nvim_create_buf(true, false), true, {relative='editor', row=math.floor((vim.opt.lines:get() - vim.opt.cmdheight:get()) * 0.7), col=0, width=math.floor(vim.opt.columns:get() * 0.5), height=math.floor((vim.opt.lines:get() - vim.opt.cmdheight:get()) * 0.25), title='dap-terminal', border='single'})"
  dap.defaults.fallback.terminal_win_cmd = "below 10split new"
  dap.defaults.fallback.focus_terminal = true

  vim.keymap.set('n', '<F5>', function() dap.continue() end)
  vim.keymap.set('n', '<F8>', function() dap.close() end)
  vim.keymap.set('n', '<F9>', function() dap.step_into() end)
  vim.keymap.set('n', '<F10>', function() dap.step_over() end)
  vim.keymap.set('n', '<F12>', function() dap.step_out() end)
  vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
  vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  vim.keymap.set('n', '<Leader>dr', function() dap.repl.open({}, "vsplit new") end)
  vim.keymap.set('n', '<Leader>db', function() dap.repl.open({}, "split new") end)
  vim.keymap.set('n', '<Leader>vk', function() require("osv").launch({port=8086}) end)
--  vim.keymap.set('n', '<Leader>dr', function() dap.repl.open({}, "lua vim.api.nvim_open_win(vim.api.nvim_create_buf(true, false), true, {relative='editor', row=math.floor((vim.opt.lines:get() - vim.opt.cmdheight:get()) * 0.7), col=math.ceil(vim.opt.columns:get() * 0.52), width=math.floor(vim.opt.columns:get() * 0.48), height=math.floor((vim.opt.lines:get() - vim.opt.cmdheight:get()) * 0.25), title='dap-repl', border='single'})") end)
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
  
  require('dap-python').setup('python')
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

  dap.configurations.lua = { 
    {
      type = 'nlua',
      request = 'attach',
      name = "Attach to running Neovim instance",
    }
  }

  dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
  end

end

return plugin
