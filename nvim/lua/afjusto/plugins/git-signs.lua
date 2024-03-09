return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = false,
			on_attach = function(bufnr)
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map(
					"n",
					"<leader>gd",
					"<cmd>Gitsigns preview_hunk_inline<CR>",
					{ buffer = bufnr, desc = "Preview hunk inline" }
				)
				map("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { buffer = bufnr, desc = "Next hunk" })
				map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { buffer = bufnr, desc = "Previous hunk" })
				map(
					"n",
					"<leader>gg",
					"<cmd>Gitsigns setqflist<CR>",
					{ buffer = bufnr, desc = "Open changes in qflist" }
				)
			end,
		})
	end,
}
