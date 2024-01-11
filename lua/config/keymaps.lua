-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here
local map = vim.keymap.set

-- Dismiss notification
map("n", "<leader>nl", function()
  require("noice").cmd("dismiss")
end)

local opts = { noremap = true, silent = true }
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Select all
map("n", "<C-a>", "ggVG")

-- Black hole register
map("n", "<leader>d", '"_')
map("v", "<leader>d", '"_')

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

map("n", "<leader>l", "vim.NIL")
map("n", "<leader>lj", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "<leader>lk", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "<leader>td", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "<leader>w", "<cmd>write<cr>")
map("n", "<leader>wd", "<cmd>noautocmd w<cr>")

map("i", "<C-f>", function()
  vim.cmd.stopinsert()
  vim.lsp.buf.signature_help()
  vim.defer_fn(function()
    vim.cmd.wincmd("w")
  end, 100)
  vim.keymap.set("n", "q", ":close<CR>", { buffer = true })
end)

-- Move panes matching tmux
--
