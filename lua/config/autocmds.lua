-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_set_hl(0, "CmpCursorLine", { bg = "#bd93f9", fg = "#2d2d2e", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#2d2d2e" })
