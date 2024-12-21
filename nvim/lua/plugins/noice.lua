return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
		})
	end,
}
