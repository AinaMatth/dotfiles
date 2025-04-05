return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 0,
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = {},
			},
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>u", group = "[U]I Toggle" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>f", group = "[F]ind" },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
}
