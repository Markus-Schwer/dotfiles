vim.keymap.set('n', '<leader>bd', function() require('b64').decode() end, { desc = '[b]ase64 [d]ecode' })
vim.keymap.set('v', '<leader>bd', function() require('b64').decode() end, { desc = '[b]ase64 [d]ecode' })

vim.keymap.set('n', '<leader>be', function() require('b64').encode() end, { desc = '[b]ase64 [e]ncode' })
vim.keymap.set('v', '<leader>be', function() require('b64').encode() end, { desc = '[b]ase64 [e]ncode' })
