local plugin = {"mfussenegger/nvim-dap"}

plugin.dependencies = {
  {"mfussenegger/nvim-dap-python"}
}

function plugin.config()
  local dap = require('dap')
  dap.defaults.switchbuf = 'v'

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

  require('dap-python').setup('uv')
  table.insert(dap.configurations.python, {
      type = 'python',
      justMyCode = false,
      request = 'launch',
      console='integratedTerminal',
      name = 'Base working directory',
      program = '${file}',
      cwd = './'
  })
  table.insert(dap.configurations.python, {
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
table.insert(dap.configurations.python, {
    type = 'python',
    request = 'attach',
    name = 'Attach to Docker',
    connect = {
      port = 5678,
      host = '127.0.0.1',
    },
    pathMappings = {
      {
        localRoot = vim.fn.getcwd(),
        remoteRoot = '/app',
      },
    }
  })

  table.insert(dap.configurations.python, {
      type = 'python',
      justMyCode = false,
      request = 'launch',
      console='integratedTerminal',
      name = 'FastAPI',
      args = {'run', '${file}', '--port', '8001'},
      program = vim.fn.exepath('fastapi'),
      cwd = './'
  })

  dap.configurations.cpp = {
    {
      name = "Launch executable",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
    {
      name = "Attach to process",
      type = "codelldb",
      request = "attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
    },
  }

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
