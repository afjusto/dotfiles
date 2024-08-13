-- Initialize a table to store information about the last closed window
local last_closed_window = {}

-- Function to save the last closed window's info
local function save_last_closed_window()
	local current_win = vim.api.nvim_get_current_win()
	local win_info = vim.fn.getwininfo(current_win)[1]

	-- Save window info if it's not the only window
	if #vim.api.nvim_tabpage_list_wins(0) > 1 then
		last_closed_window = {
			buf = vim.api.nvim_win_get_buf(current_win),
			is_vertical = win_info.wincol > 0,
		}
	else
		last_closed_window = {}
	end
end

-- Function to reopen the last closed window
function _G.reopen_last_closed_window()
	if next(last_closed_window) ~= nil then
		local buf = last_closed_window.buf
		local is_vertical = last_closed_window.is_vertical

		if is_vertical then
			vim.api.nvim_command("vsplit")
		else
			vim.api.nvim_command("split")
		end

		local new_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(new_win, buf)
		last_closed_window = {} -- Reset after reopening
	else
		print("No recently closed window to reopen.")
	end
end

-- Autocommand to save the last closed window info
vim.api.nvim_create_autocmd("WinClosed", {
	callback = function()
		save_last_closed_window()
	end,
})

vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" })
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Go to end of line" })

-- split management
vim.keymap.set("n", "<leader>ws", "<C-w>v", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make split windows equally " })
vim.keymap.set("n", "<leader>wq", ":close<CR>", { desc = "Close split window" })
vim.keymap.set("n", "<leader>wr", ":lua reopen_last_closed_window()<CR>", { noremap = true, silent = true })

-- buffer management
-- vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>s", ":w<CR>", { desc = "Save buffer" })

-- tree explorer
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer on current file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "Q", "<nop>", { silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center previous search result" })
vim.keymap.set({ "v" }, "<leader>D", [["_d]], { desc = "Delete to black hole register" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set(
	"n",
	"<leader>rw",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor" }
)

vim.keymap.set("n", "<leader>o", "o<ESC>", { desc = "Insert new line below" })
vim.keymap.set("n", "<leader>O", "O<ESC>", { desc = "Insert new line above" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "yp", "<cmd>let @+ = expand('%:~:.')<cr>", { desc = "Copy relative path" })
vim.keymap.set("n", "yP", "<cmd>let @+ = expand('%:p')<cr>", { desc = "Copy absolute path" })
