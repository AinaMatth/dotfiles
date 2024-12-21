return {
	'nvim-lualine/lualine.nvim',
	event = 'VeryLazy',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local icons = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		require('lualine').setup({
			options = {
				theme = 'auto',
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch' },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.Error,
								warn = icons.Warn,
								info = icons.Info,
								hint = icons.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					},
					lualine_x = {
						Snacks.profiler.status(),
						-- stylua: ignore
						{
							function() return require("noice").api.status.command.get() end,
							cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
							color = function() return { fg = Snacks.util.color("Statement") } end,
						},
						-- stylua: ignore
						{
							function() return require("noice").api.status.mode.get() end,
							cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
							color = function() return { fg = Snacks.util.color("Constant") } end,
						},
						-- stylua: ignore
						{
							function() return "  " .. require("dap").status() end,
							cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
							color = function() return { fg = Snacks.util.color("Debug") } end,
						},
						-- stylua: ignore
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = function() return { fg = Snacks.util.color("Special") } end,
						},
					},
					lualine_y = {
						{ "progress", separator = " ",                  padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
					extensions = { "neo-tree", "lazy", "fzf" },
				},
			},
		})
	end,
}
