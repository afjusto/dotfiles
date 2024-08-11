return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_filetypes = {
			["*"] = false,
			["javascript"] = true,
			["typescript"] = true,
			["typescriptreact"] = true,
			["javascriptreact"] = true,
			["json"] = true,
			["lua"] = true,
			["ruby"] = true,
			["python"] = true,
			["go"] = true,
			["rust"] = true,
			["css"] = true,
			["scss"] = true,
			["sass"] = true,
			["less"] = true,
			["yaml"] = true,
			["toml"] = true,
			["bash"] = true,
			["markdown"] = true,
			["sql"] = true,
			["graphql"] = true,
		}
	end,
}
