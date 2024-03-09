return {
	"otavioschwanck/arrow.nvim",
	opts = {
		leader_key = "<leader>h",
		separate_by_branch = true,
		mappings = {
			edit = "e",
			delete_mode = "d",
			clear_all_items = "C",
			toggle = "a", -- used as save if separate_save_and_remove is true
			open_vertical = "<C-v>",
			open_horizontal = "<C-x>",
			quit = "q",
			remove = "x", -- only used if separate_save_and_remove is true
		},
	},
}
