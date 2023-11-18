vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<ESC>", { desc = "Leave insert mode" })

vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" })
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Go to end of line" })

-- split management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equally " })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close split window" })

-- buffer management
vim.keymap.set("n", "<leader>bx", ":bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save buffer" })

-- symbols outline
vim.keymap.set("n", "<leader>oo", ":SymbolsOutline<CR>", { desc = "Toggle outline" })

-- tree explorer
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
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
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole register" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set(
	"n",
	"<leader>rw",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor" }
)
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
	require("refactoring").select_refactor()
end, { desc = "Refactor" })

vim.keymap.set("n", "<leader>o", "o<ESC>", { desc = "Insert new line below" })
vim.keymap.set("n", "<leader>O", "O<ESC>", { desc = "Insert new line above" })
