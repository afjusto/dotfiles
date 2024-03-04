return {
	"f-person/git-blame.nvim",
	config = function()
		require("gitsigns").setup({
			enabled = false,
		})

		vim.keymap.set(
			"n",
			"<Leader>go",
			":GitBlameOpenCommitURL<CR>",
			{ noremap = true, silent = true, desc = "Open commit URL" }
		)
	end,
}
