vim.keymap.set({ "n", "v" }, "<leader>gg", vim.cmd.Git, { desc = "[g]o [g]it" })
vim.keymap.set("n", "<leader>ch", "<Plug>fugitive:d2o", { desc = "difftool [c]hoose the diff hunk from the ours version of the file" })
vim.keymap.set("n", "<leader>cl", "<Plug>fugitive:d3o", { desc = "difftool [c]hoose the diff hunk from the theirs version of the file" })

