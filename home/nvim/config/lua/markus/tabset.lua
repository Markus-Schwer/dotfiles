require("tabset").setup({
	defaults = {
		tabwidth = 4,
		expandtab = true,
	},
	languages = {
		{
			filetypes = { "go", "templ", "lua", "make" },
			config = {
				tabwidth = 4,
				expandtab = false,
			},
		},
		{
			filetypes = { "nix", "kotlin", "json", "yaml" },
			config = {
				tabwidth = 2,
				expandtab = true,
			},
		},
	},
})
