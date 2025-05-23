-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.g.root_spec = { "cwd" } -- Change root detection

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = false
vim.g.snacks_animate = false

local opt = vim.opt

opt.shiftwidth = 4 -- Size of an indent
opt.relativenumber = true -- Relative line numbers

-- Neovide Begin (More info at https://neovide.dev/configuration.html)
if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_window_blurred = true
  vim.g.neovide_transparency = 0.9
  -- vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  -- vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  -- vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  -- vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  -- vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end
-- Neovide End
