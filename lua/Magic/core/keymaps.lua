vim.g.mapleader = " "

-- for remapping keys and that sort

local keymap = vim.keymap

-- general keymaps

-- Leaving terminal mode is (C-\ C-N), here's a better one!
keymap.set("t", "<ESC>", "<C-\\><C-n>")

keymap.set("n", "<leader>x", '"_x')

keymap.set("n", "<leader>n", ":NewTerminal<CR>")
-- Splitting the window and switching between windows

keymap.set("n", "<c-H>", "<C-w><")
keymap.set("n", "<c-J>", "<C-w>-")
keymap.set("n", "<c-K>", "<C-w>+")
keymap.set("n", "<c-L>", "<C-w>>")


keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-j>", "<C-w>j")

keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>sv", "<C-w>v")

keymap.set("n", "<C-X>", ":bd<CR>")
keymap.set("n", "<C-x>", ":close<CR>")

-- Tabs

keymap.set("n", "<leader>t", ":tabnew<CR>")
keymap.set("n", "<leader><TAB>", ":tabn<CR>")
keymap.set("n", "<leader><S-TAB>", ":tabp<CR>")

-- plugin keymaps

keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- NvimTree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

keymap.set("n", "<leader>T", ":NvimTreeFocus<CR>")

-- Telescope Keybinds
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- Code runner (My own)
keymap.set("n", "<leader>r", ":Run<CR>")
