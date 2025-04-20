require("nvim-treesitter.configs").setup({
	parser_install_dir = "~/.local/share/nvim/site",
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
	},
})
