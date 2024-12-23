-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local key = vim.keymap.set
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
key("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode
key("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- save file
key({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- quit
key("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Lazy
key("n", "<leader>l", "<cmd>:Lazy<CR>", { desc = "Lazy" })

-- Lazy
key("n", "<leader>m", "<cmd>:Mason<CR>", { desc = "Mason" })
