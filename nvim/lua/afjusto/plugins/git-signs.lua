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
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 500,
			},
			on_attach = function(bufnr)
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "<leader>gd", "<cmd>Gitsigns preview_hunk_inline<CR>", { buffer = bufnr })
				map("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { buffer = bufnr })
				map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { buffer = bufnr })
				map("n", "<leader>xg", "<cmd>Gitsigns setqflist<CR>", { buffer = bufnr }) -- use trouble
			end,
		})
	end,
}
