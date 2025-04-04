return {
	{
		'echasnovski/mini.pairs',
		ft = { "lua", "javascript", "typescript", "bash", "python", "html", "css", "php", "rust", "java" }, -- Specify programming file types
		config = function()
			require('mini.pairs').setup({
				modes = { insert = true, command = true }, -- Enable in insert and command modes
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],  -- Characters to skip
				skip_ts = { "string" },                -- Skip pairs in strings
				skip_unbalanced = true,                -- Skip unbalanced pairs
				markdown = true,                       -- Enable for markdown files (optional)
				-- Custom pairs for HTML tags
				custom_pairs = {
					['<'] = '>', -- Auto-close HTML tags
					['{'] = '}', -- Auto-close curly braces
					['('] = ')', -- Auto-close parentheses
					['['] = ']', -- Auto-close brackets
				},
			})
		end,
	},
	{
		'echasnovski/mini.surround',
		version = '*',
		recommended = true,
		event = 'VeryLazy',
		config = function()
			require('mini.surround').setup()
		end,
	},
}
