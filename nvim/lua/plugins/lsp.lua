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
					{ path = "snacks.nvim",        words = { "Snacks" } },
				},
			},
		},
		{
			'saghen/blink.cmp',
			opts = {
				sources = {
					-- add lazydev to your completion providers
					default = { "lazydev", "lsp", "path", "snippets", "buffer" },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							-- make lazydev completions top priority (see `:h blink.cmp`)
							score_offset = 100,
						},
					},
				},
			},
		}
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

		-- Blink integration
		local capabilities = require('blink.cmp').get_lsp_capabilities()

		-- LSP Attach config
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then return end
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
			capabilities = capabilities,
		}
		lsp.phpactor.setup {
			on_attach = on_attach,
			init_options = {
				["language_server_phpstan.enabled"] = false,
				["language_server_psalm.enabled"] = false,
			},
			capabilities = capabilities,
		}
		require 'lspconfig'.ts_ls.setup {
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
						languages = { "javascript", "typescript", "vue" },
					},
				},
			},
			filetypes = {
				"javascript",
				"typescript",
				"vue",
				"javascriptreact",
				"javascript.jsx",
				"typescriptreact",
				"typescript.tsx",
			},
			capabilities = capabilities,
		}

		-- You must make sure volar is setup
		-- e.g. require'lspconfig'.volar.setup{}
		-- See volar's section for more information
	end,
}
