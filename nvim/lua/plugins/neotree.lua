return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	keys = {
		{ "n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
	},
}
