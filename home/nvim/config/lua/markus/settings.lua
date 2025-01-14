-- keymap leader
vim.g.mapleader = " "
-- render whitespaces
vim.o.list = true
--vim.o.listchars = 'tab:» ,lead:·,trail:·,eol:¬,extends:…'
-- line numbers
vim.o.nu = true
vim.o.relativenumber = false
-- indent config
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
--vim.o.expandtab = true
--vim.o.smartindent = true
vim.o.wrap = false
--vim.o.colorcolumn = '80'
vim.o.textwidth = 80 -- this enables re-arranging lines with gq
vim.o.formatoptions = "cqj"
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*.tex", "*.md", "*.adoc", "*.txt" },
	callback = function()
		vim.opt_local.formatoptions = "tcqj" -- auto formatting for text as well
	end,
})
-- history
vim.o.backup = false
vim.o.swapfile = false
vim.o.undofile = true
--vim.o.undodir = vim.fn.stdpath('data') .. '/undodir'
-- visuals
vim.o.termguicolors = true -- is also set automatically by some themes
vim.o.signcolumn = "yes:5" -- give plenty of space for signs
vim.o.cmdheight = 2
vim.o.scrolloff = 8 -- don't let cursor get too close to the edge
-- performance
vim.o.updatetime = 50
vim.o.hidden = true -- keep hidden buffers
-- searching
vim.o.ignorecase = true
vim.o.smartcase = true
-- splits: by default split to right and below
vim.o.splitright = true
vim.o.splitbelow = true
-- clipboard sharing
vim.opt.clipboard = "unnamedplus"
-- delete without yanking
vim.keymap.set("n", "d", '"_d', { desc = "[d]elete and yank into black hole register" })
-- easy quickfix navigation
vim.keymap.set("n", "]q", ":cnext<cr>", { desc = "[q]uickfix select next item" })
vim.keymap.set("n", "[q", ":cprevious<cr>", { desc = "[q]uickfix select next item" })
vim.keymap.set("n", "]Q", ":clast<cr>", { desc = "[Q]uickfix select last item" })
vim.keymap.set("n", "[Q", ":cfirst<cr>", { desc = "[Q]uickfix select first item" })
