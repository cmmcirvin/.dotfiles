local plugin = {"mfussenegger/nvim-dap"}

plugin.dependencies = {
  {"mfussenegger/nvim-dap-python"}
}

function plugin.config()
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

end

return plugin
