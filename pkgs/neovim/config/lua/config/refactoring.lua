require('refactoring').setup()

vim.keymap.set({ "n", "x" }, "<leader>ra", function() return require('refactoring').select_refactor() end, { expr = true, desc = '[r]efactoring [a]ctions' })
