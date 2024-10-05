-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move lines in normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")

-- Move lines in insert mode
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Move lines in visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Plugins
vim.keymap.set("n", "<leader>pmd", ":MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
vim.keymap.set("n", "<leader>pfs", ":FiveServer start<CR>", { desc = "Start FiveServer" })
vim.keymap.set("n", "<leader>rn", ":IncRename<CR>", { desc = "Inc Rename w/ LSP" })
