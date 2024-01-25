return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = function(_, path)
					local tail = require("telescope.utils").path_tail(path)
					return string.format("%s (%s)", tail, path), { { { 1, #tail }, "Constant" } }
				end,
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")
		local utils = require("telescope.utils")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fd", function()
			builtin.find_files({ cwd = utils.buffer_dir() })
		end, { desc = "Find files in current directory" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string" })
		-- vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fc", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set({ "n", "x" }, "<leader>rr", function()
			require("telescope").extensions.refactoring.refactors()
		end)
		vim.keymap.set({ "n", "x" }, "<leader>rr", function()
			require("refactoring").select_refactor()
		end)
	end,
}
