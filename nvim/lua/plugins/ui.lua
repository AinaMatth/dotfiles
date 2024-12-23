return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				preset = {
					header = [[

	 █████╗ ██╗███╗   ██╗ █████╗
	██╔══██╗██║████╗  ██║██╔══██╗
	███████║██║██╔██╗ ██║███████║
	██╔══██║██║██║╚██╗██║██╔══██║
	██║  ██║██║██║ ╚████║██║  ██║
	╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝


   ]],
				},
			},
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
		--diagnostics
		keys = { -- HACK: undefined snacks variable?
			{ "<leader>.",  function() Snacks.scratch() end,          desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end,   desc = "Select Scratch Buffer" },
			{ "<leader>gB", function() Snacks.gitbrowse() end,        desc = "Git Browse",                  mode = { "n", "v" } },
			{ "<leader>gb", function() Snacks.git.blame_line() end,   desc = "Git Blame Line" },
			{ "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
			{ "<leader>gg", function() Snacks.lazygit() end,          desc = "Lazygit" },
			{ "<leader>gl", function() Snacks.lazygit.log() end,      desc = "Lazygit Log (cwd)" },
		}
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			signs = true,
			keywords = {
				TEST = { icon = "󰥔 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		}
	},
}