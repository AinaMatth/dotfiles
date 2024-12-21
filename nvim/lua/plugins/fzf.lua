return {
	"ibhagwan/fzf-lua",
	event = 'VimEnter',
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({

		})
	end,
}