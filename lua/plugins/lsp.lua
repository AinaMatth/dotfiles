return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"j-hui/fidget.nvim",
				tag = "v1.4.0",
				opts = {
					progress = {
						display = {
							done_icon = "✓",
						},
					},
					notification = {
						window = {
							winblend = 0,
						},
					},
				},
			},
			{ "saghen/blink.cmp" },
		},
		config = function()
			require("core.lsp").setup() -- Call the setup function from the module
		end,
	},
	require("plugins.lsp.ts"),
}
