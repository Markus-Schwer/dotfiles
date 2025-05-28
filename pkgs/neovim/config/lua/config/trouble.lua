require("trouble").setup({
	modes = {
		workspace_diagnostics = {
			mode = "diagnostics",
			filter = {
				{
					function (item)
						return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
					end
				}
			},
		},
		document_diagnostics = {
			mode = "diagnostics",
			filter = { buf = 0 },
		},
	},
})

vim.keymap.set("n", "<leader>tt", function()
	require("trouble").toggle("diagnostics")
end, { desc = "[t]roubles [t]oggle" })
vim.keymap.set("n", "<leader>tw", function()
	require("trouble").toggle("workspace_diagnostics")
end, { desc = "[t]rouble toggle [w]orkspace diagnostics" })
vim.keymap.set("n", "<leader>td", function()
	require("trouble").toggle("document_diagnostics")
end, { desc = "[t]rouble toggle [d]ocument diagnostics" })
vim.keymap.set("n", "<leader>tq", function()
	require("trouble").toggle("quickfix")
end, { desc = "[t]rouble toggle [q]uickfix" })
vim.keymap.set("n", "<leader>tl", function()
	require("trouble").toggle("loclist")
end, { desc = "[t]rouble toggle [l]oclist" })
vim.keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end, { desc = "[g] go to trouble lsp [R]eferences" })
