require("nvim_sops").setup({})

vim.keymap.set("n", "<leader>se", vim.cmd.SopsEncrypt, { desc = "[s]ops [e]ncrypt" })
vim.keymap.set("n", "<leader>sd", vim.cmd.SopsDecrypt, { desc = "[s]ops [d]ecrypt" })
