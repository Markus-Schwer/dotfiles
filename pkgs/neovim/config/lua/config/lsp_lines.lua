require("lsp_lines").setup()
vim.diagnostic.config({ virtual_text = false })
-- toggle diagnostics to avoid clashes
local diagnostics_active = true
vim.keymap.set("n", "<leader>dt", function()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end, { desc = "[d]iagnostics [t]oggle " })

vim.keymap.set("n", "<leader>lt", function()
	require("lsp_lines").toggle()
end, { desc = "lsp_[l]ines [t]oggle " })
