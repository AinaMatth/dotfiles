-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local opts = { noremap = true, silent = true }
local key = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
key('n', '<Esc>', '<cmd>nohlsearch<CR>',opts)

-- Source file
key('n', '<leader><leader>','<cmd>source %<CR>')

-- Lua command
key('n', '<leader>x',':lua<CR>')

-- Diagnostic keymaps
key('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' },opts)

-- Exit terminal mode
key('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' },opts)

-- save file
key({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" }, opts)

-- quit
key("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" }, opts)

-- Lazy
key('n','<leader>l','<cmd>:Lazy<CR>', {desc = 'Open Lazy'}, opts)

-- Quickfix
key("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" },opts)
key("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" },opts)

key("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" },opts)
key("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" },opts)

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
key("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" },opts)
key("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" },opts)
key("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" },opts)
key("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" },opts)
key("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" },opts)
key("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" },opts)
key("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" },opts)
