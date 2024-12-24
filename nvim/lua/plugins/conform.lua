return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black", "ruff" },
			javascript = { "prettierd", "prettier", "biome", stop_after_first = true },
			typescript = { "prettier", "biome" },
			javascriptreact = { "prettier", "biome" },
			typescriptreact = { "prettier", "biome" },
			svelte = { "prettier", "biome" },
			css = { "prettier", "biome" },
			html = { "prettier", "biome" },
			php = { "php-cs-fixer" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = { timeout_ms = 500 },
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
