return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				theme = "tokyonight",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = {
					{
						function()
							for _, buf in ipairs(vim.api.nvim_list_bufs()) do
								if vim.api.nvim_buf_get_option(buf, "modified") then
									return "⚠️ "
								end
							end
							return ""
						end,
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},
			winbar = {
				lualine_c = {
					{
						"navic",
						color_correction = nil,
						navic_opts = nil,
					},
				},
			},
		})
	end,
}
