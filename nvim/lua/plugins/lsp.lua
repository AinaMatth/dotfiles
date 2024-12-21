return {
	'neovim/nvim-lspconfig',
	event = 'VeryLazy',
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		local lsp = require 'lspconfig'

		-- Pretty icons for warning messages
		local icons = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = icons.Error,
					[vim.diagnostic.severity.WARN] = icons.Warn,
					[vim.diagnostic.severity.HINT] = icons.Hint,
					[vim.diagnostic.severity.INFO] = icons.Info,
				}
			},
			underline = true,
			update_in_insert = false,
			severity_sort = false,
		})

		-- LSP Attach config
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if  not client then return end
				if client:supports_method('textDocument/implementation') then
					-- Create a keymap for vim.lsp.buf.implementation
				end

				if client:supports_method('textDocument/completion') then
					-- Enable auto-completion
					vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
				end

				if client:supports_method('textDocument/formatting') then
					-- Format the current buffer on save
					vim.api.nvim_create_autocmd('BufWritePre', {
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
						end,
					})
				end
			end,
		})

		-- LSP settings
		lsp.lua_ls.setup {
		}
	end,
}
