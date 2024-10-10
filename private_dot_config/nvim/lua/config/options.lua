-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.shiftwidth = 2 -- Size of an indent
opt.relativenumber = false -- Relative line numbers

-- Neovide Begin
if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
end
-- Neovide End
