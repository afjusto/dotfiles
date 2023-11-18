return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>ha", function()
			mark.add_file()
		end, { desc = "Mark file with harpoon" })

		vim.keymap.set("n", "<leader>hn", function()
			ui.nav_next()
		end, { desc = "Go to next harpoon mark" })

		vim.keymap.set("n", "<leader>hp", function()
			ui.nav_prev()
		end, { desc = "Go to previous harpoon mark" })

		vim.keymap.set("n", "<leader>hl", function()
			ui.toggle_quick_menu()
		end, { desc = "Toggle harpoon quick menu" })

		vim.keymap.set("n", "<leader>h1", function()
			ui.nav_file(1)
		end, { desc = "Go to harpoon mark 1" })

		vim.keymap.set("n", "<leader>h2", function()
			ui.nav_file(2)
		end, { desc = "Go to harpoon mark 2" })

		vim.keymap.set("n", "<leader>h3", function()
			ui.nav_file(3)
		end, { desc = "Go to harpoon mark 3" })

		vim.keymap.set("n", "<leader>h4", function()
			ui.nav_file(4)
		end, { desc = "Go to harpoon mark 4" })
	end,
}
