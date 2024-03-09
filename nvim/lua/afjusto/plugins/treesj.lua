return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({
			max_join_length = 50000,
			use_default_keymaps = false,
		})
		vim.keymap.set("n", "<leader>m", ":lua require('treesj').toggle()<CR>", { desc = "Toggle node" })
	end,
}
