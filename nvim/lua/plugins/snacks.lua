return {
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
			}
		},
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		scope = { enabled = true },
	},
	keys = {
		{ "<leader>zn", function() Snacks.zen() end,              desc = "Zen Mode" },
		{ "<leader>zz", function() Snacks.zen.zoom() end,         desc = "Zen Zoom" },
		{ "<leader>bs", function() Snacks.scratch() end,          desc = "Scratch Buffer" },
		{ "<leader>bS", function() Snacks.scratch.select() end,   desc = "Scratch Buffer Selection" },
		{ "<leader>gb", function() Snacks.git.blame_line() end,   desc = "Git Blame Line" },
		{ "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
		{ "<leader>gg", function() Snacks.lazygit() end,          desc = "Lazygit" },
		{ "<leader>gl", function() Snacks.lazygit.log() end,      desc = "Lazygit Log (cwd)" },
	},
}
