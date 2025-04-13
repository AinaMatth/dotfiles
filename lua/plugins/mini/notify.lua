	require("mini.notify").setup({
		window = {
			config = {
				row = 2,
			},
			max_width_share = 0.5,
			winblend = 0,
		},
	})
	vim.notify = MiniNotify.make_notify()
