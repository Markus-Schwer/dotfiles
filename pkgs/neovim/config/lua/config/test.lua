local neotest = require("neotest")

neotest.setup({
  adapters = {
    require("neotest-golang")({
      go_test_args = { "-count=1", "-tags=unit,api,int" },
      go_list_args = { "-tags=unit,api,int" },
      dap_go_opts = {
        delve = {
          build_flags = { "-tags=unit,api,int" },
        },
      },
    })
  },
})

vim.keymap.set('n', '<Leader>td', function() neotest.run.run({ suite = false, strategy = "dap" }) end, { desc = 'run nearest [t]est with [d]ebugger' })
vim.keymap.set('n', '<Leader>ta', function() neotest.run.attach() end, { desc = "[t]est [a]ttach" })
vim.keymap.set('n', '<Leader>tf', function() neotest.run.run(vim.fn.expand("%")) end, { desc = "[t]est run [f]ile" })
vim.keymap.set('n', '<Leader>tA', function() neotest.run.run(vim.uv.cwd()) end, { desc = "[t]est [A]ll files" })
vim.keymap.set('n', '<Leader>tS', function() neotest.run.run({ suite = true }) end, { desc = "[t]est [S]uite" })
vim.keymap.set('n', '<Leader>tn', function() neotest.run.run() end, { desc = "[t]est [n]earest" })
vim.keymap.set('n', '<Leader>tl', function() neotest.run.run_last() end, { desc = "[t]est [l]ast" })
vim.keymap.set('n', '<Leader>ts', function() neotest.summary.toggle() end, { desc = "[t]est [s]ummary" })
vim.keymap.set('n', '<Leader>to', function() neotest.output.open({ enter = true, auto_close = true }) end, { desc = "[t]est [o]utput" })
vim.keymap.set('n', '<Leader>tO', function() neotest.output_panel.toggle() end, { desc = "[t]est [O]utput panel" })
vim.keymap.set('n', '<Leader>tt', function() neotest.run.stop() end, { desc = "[t]est [t]erminate" })
vim.keymap.set('n', '<Leader>td', function() neotest.run.run({ suite = false, strategy = "dap" }) end, { desc = "Debug nearest test" })
vim.keymap.set('n', '<Leader>tD', function() neotest.run.run({ vim.fn.expand("%"), strategy = "dap" }) end, { desc = "Debug current file" })
