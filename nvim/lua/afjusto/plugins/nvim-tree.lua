return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")
		local HEIGHT_RATIO = 0.8
		local WIDTH_RATIO = 0.5

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- configure nvim-tree
		nvimtree.setup({
			view = {
				relativenumber = true,
				-- float = {
				-- 	enable = false,
				-- 	open_win_config = function()
				-- 		local screen_w = vim.opt.columns:get()
				-- 		local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				-- 		local window_w = screen_w * WIDTH_RATIO
				-- 		local window_h = screen_h * HEIGHT_RATIO
				-- 		local window_w_int = math.floor(window_w)
				-- 		local window_h_int = math.floor(window_h)
				-- 		local center_x = (screen_w - window_w) / 2
				-- 		local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				-- 		return {
				-- 			border = "rounded",
				-- 			relative = "editor",
				-- 			row = center_y,
				-- 			col = center_x,
				-- 			width = window_w_int,
				-- 			height = window_h_int,
				-- 		}
				-- 	end,
				-- },
				width = function()
					return 40
					-- return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				end,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
			},
			-- disable window_picker for explorer to work well with window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})
	end,
}
