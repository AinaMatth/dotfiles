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
		{ "<leader>Gb", function() Snacks.git.blame_line() end,   desc = "Git Blame Line" },
		{ "<leader>Gf", function() Snacks.lazygit.log_file() end, desc = "git Current File History" },
		{ "<leader>Gg", function() Snacks.lazygit() end,          desc = "git" },
		{ "<leader>Gl", function() Snacks.lazygit.log() end,      desc = "git Log (cwd)" },
	},
}
