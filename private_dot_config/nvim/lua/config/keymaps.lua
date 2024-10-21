-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Moving lines
-- vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
-- vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
--
-- vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
-- vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
--
-- vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
-- vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Switch between buffers
vim.keymap.set("n", "<Tab>", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })

-- Moving between words
-- vim.keymap.set("n", "L", "w", { desc = "Move to next word" })
-- vim.keymap.set("n", "H", "b", { desc = "Move to previous word" })
--
-- vim.keymap.set("v", "L", "w", { desc = "Move to next word" })
-- vim.keymap.set("v", "H", "b", { desc = "Move to previous word" })

-- Plugins
vim.keymap.set("n", "<leader>pmd", ":MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
vim.keymap.set("n", "<leader>pfs", ":FiveServer start<CR>", { desc = "Start FiveServer" })
vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Inc Rename w/ LSP" })
