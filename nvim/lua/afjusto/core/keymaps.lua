vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" })
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Go to end of line" })

-- split management
vim.keymap.set("n", "<leader>Wv", "<C-w>v", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>Wh", "<C-w>s", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>We", "<C-w>=", { desc = "Make split windows equally " })
vim.keymap.set("n", "<leader>Wx", ":close<CR>", { desc = "Close split window" })

-- buffer management
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save buffer" })

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
