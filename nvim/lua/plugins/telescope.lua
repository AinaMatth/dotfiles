--NOTE: Old config
-- return {
-- 	"nvim-telescope/telescope.nvim",
-- 	event = "VeryLazy",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		{
-- 			"nvim-telescope/telescope-fzf-native.nvim",
-- 			build = "make",
-- 			cond = function()
-- 				return vim.fn.executable("make") == 1
-- 			end,
-- 			cmd = "Telescope", -- Load only when needed
-- 		},
-- 		{ "nvim-telescope/telescope-ui-select.nvim", cmd = "Telescope" },
-- 		{ "nvim-tree/nvim-web-devicons",             enabled = vim.g.have_nerd_font },
-- 	},
-- 	config = function()
-- 		local telescope = require("telescope")
--
-- 		-- Telescope setup with minimal defaults
-- 		telescope.setup({
-- 			defaults = {
-- 				prompt_prefix = " ",
-- 				selection_caret = " ",
-- 			},
-- 			extensions = {
-- 				["ui-select"] = require("telescope.themes").get_dropdown(),
-- 			},
-- 		})
--
-- 		-- Load extensions
-- 		local function load_extensions()
-- 			local success, _ = pcall(telescope.load_extension, "fzf")
-- 			if not success then
-- 				print("Failed to load fzf extension")
-- 			end
-- 			success, _ = pcall(telescope.load_extension, "ui-select")
-- 			if not success then
-- 				print("Failed to load ui-select extension")
-- 			end
-- 		end
--
-- 		-- Lazy load extensions
-- 		vim.api.nvim_create_autocmd("User", {
-- 			pattern = "TelescopeStarted",
-- 			callback = load_extensions,
-- 		})
--
-- 		-- Key mappings for Telescope functions
-- 		local builtin = require("telescope.builtin")
-- 		local map = vim.keymap.set
-- 		local desc = function(text)
-- 			return { desc = text }
-- 		end
--
-- 		-- Basic mappings
-- 		local mappings = {
-- 			{ "n", "<leader>sh",       builtin.help_tags,   "[S]earch [H]elp" },
-- 			{ "n", "<leader>sk",       builtin.keymaps,     "[S]earch [K]eymaps" },
-- 			{ "n", "<leader>sf",       builtin.find_files,  "[S]earch [F]iles" },
-- 			{ "n", "<leader>ss",       builtin.builtin,     "[S]earch [S]elect Telescope" },
-- 			{ "n", "<leader>sw",       builtin.grep_string, "[S]earch current [W]ord" },
-- 			{ "n", "<leader>sg",       builtin.live_grep,   "[S]earch by [G]rep" },
-- 			{ "n", "<leader>sd",       builtin.diagnostics, "[S]earch [D]iagnostics" },
-- 			{ "n", "<leader>sr",       builtin.resume,      "[S]earch [R]esume" },
-- 			{ "n", "<leader>s.",       builtin.oldfiles,    '[S]earch Recent Files ("." for repeat)' },
-- 			{ "n", "<leader><leader>", builtin.buffers,     "[ ] Find existing buffers" },
-- 			{
-- 				"n",
-- 				"<leader>/",
-- 				function()
-- 					builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
-- 						winblend = 10,
-- 						previewer = false,
-- 					}))
-- 				end,
-- 				"[/] Fuzzily search in current buffer",
-- 			},
-- 			{
-- 				"n",
-- 				"<leader>s/",
-- 				function()
-- 					builtin.live_grep({
-- 						grep_open_files = true,
-- 						prompt_title = "Live Grep in Open Files",
-- 					})
-- 				end,
-- 				"[S]earch [/] in Open Files",
-- 			},
-- 			{
-- 				"n",
-- 				"<leader>sc",
-- 				function()
-- 					builtin.find_files({ cwd = vim.fn.stdpath("config") })
-- 				end,
-- 				"[S]earch [N]eovim files",
-- 			},
-- 		}
--
-- 		-- Set key mappings
-- 		for _, mapping in ipairs(mappings) do
-- 			map(mapping[1], mapping[2], mapping[3], desc(mapping[4]))
-- 		end
-- 	end,
-- }
-- NOTE: New config
local M = {}

-- Helper functions to detect build command
local function get_build_cmd()
	for _, cmd in ipairs({ "make", "cmake", "gmake" }) do
		if vim.fn.executable(cmd) == 1 then
			return cmd
		end
	end
	return nil
end

local function get_find_command()
	if vim.fn.executable("rg") == 1 then
		return { "rg", "--files", "--color", "never", "-g", "!.git" }
	elseif vim.fn.executable("fd") == 1 then
		return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
	elseif vim.fn.executable("fdfind") == 1 then
		return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
	elseif vim.fn.executable("find") and not vim.fn.has("win32") then
		return { "find", ".", "-type", "f" }
	elseif vim.fn.executable("where") == 1 then
		return { "where", "/r", ".", "*" }
	end
end

-- Main telescope configuration
return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		event = "VeryLazy",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = function()
					local build_cmd = get_build_cmd()
					if build_cmd == "cmake" then
						return
						"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
					else
						return "make"
					end
				end,
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
		},
		keys = {

			{
				"n",                                                             -- Mode: Normal
				"<leader>sc",                                                    -- Key combination
				'<cmd>Telescope find_files({ cwd = vim.fn.stdpath("config") })<CR>', -- Command to execute
				"[S]earch [N]eovim files",                                       -- Description of the mapping
			},
			{
				"<leader>s/",
				"<cmd>Telescope live_grep<cr>",
				desc = "Grep (Root Dir)",
			},
			{ "<leader>sf", "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
			{
				"<leader>sg",
				"<cmd>Telescope git_files<cr>",
				desc = "Find Files (git-files)",
			},
			{ "<leader>sr", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent Files" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>",               desc = "Git Commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>",                desc = "Git Status" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{
				"<leader>sd",
				"<cmd>Telescope diagnostics bufnr=0<cr>",
				desc = "Document Diagnostics",
			},
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					n = {
						["q"] = require("telescope.actions").close,
					},
				},
				get_selection_window = function()
					local wins = vim.api.nvim_list_wins()
					table.insert(wins, 1, vim.api.nvim_get_current_win())
					for _, win in ipairs(wins) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].buftype == "" then
							return win
						end
					end
					return 0
				end,
			},
			pickers = {
				find_files = {
					find_command = get_find_command(),
					hidden = true,
				},
			},
		},
	},
}
