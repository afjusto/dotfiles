return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		vim.keymap.set("n", "<leader>T", ":TestNearest<CR>")
		vim.keymap.set("n", "<leader>t", ":TestFile<CR>")
		vim.cmd("let test#strategy = 'vimux'")
		vim.cmd("let test#javascript#jest#options = '--watch'")

		vim.cmd("let g:VimuxOrientation = 'h'")
		vim.cmd("let g:VimuxHeight = 40")
	end,
}
