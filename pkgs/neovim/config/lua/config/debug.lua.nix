{ pkgs, ... }:

''
  local dap = require('dap')
  require("dap-go").setup {
    dap_configurations = {
      {
        type = "go",
        name = "Attach remote",
        mode = "remote",
        request = "attach",
        port = "38697",
      },
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = "''${workspaceFolder}",
      stopAtEntry = true,
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = "''${workspaceFolder}",
      stopAtEntry = true,
    }
  }

  vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'continue' })
  vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'step over' })
  vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'step into' })
  vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'step out' })
  vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'toggle [b]reakpoint' })
  vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, { desc = 'set [B]reakpoint' })
  vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'set [b]reakpoint ([l]og)' })
  vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = 'open [d]ebug [r]epl' })
  vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = '[d]ebug / run [l]last' })
  vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = '[d]ebug [h]over' })
  vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
  end, { desc = '[d]ebug [p]review' })
  vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end, { desc = '[d]ebug with [f]frames' })
  vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end, { desc = '[d]ebug [s]copes' })
''
