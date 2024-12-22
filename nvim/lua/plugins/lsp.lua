return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', config = true }, -- Must be loaded before dependants
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			{ 'j-hui/fidget.nvim',       opts = {} },
			{
				'folke/lazydev.nvim',
				ft = 'lua',
				opts = {
					library = {
						{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
					},
				},
			},
			{ 'saghen/blink.cmp' },
		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('LspAttachGroup', { clear = true }), -- Group for LSP attach events
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					-- Key mappings for LSP features
					local function map_key(keys, func, desc)
						vim.keymap.set('n', keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
					end

					if client:supports_method('textDocument/implementation') then
						map_key('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
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
			-- Diagnostic configuration
			local icons = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.Error,
						[vim.diagnostic.severity.WARN]  = icons.Warn,
						[vim.diagnostic.severity.HINT]  = icons.Hint,
						[vim.diagnostic.severity.INFO]  = icons.Info,
					}
				},
				underline = true,
				update_in_insert = false,
				severity_sort = false,
			})

			-- Setup capabilities for LSP clients
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

			-- Define LSP servers configuration
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
							diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Mason setup
			require('mason').setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { 'stylua' })
			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			require('mason-lspconfig').setup {
				handlers = {
					function(server_name)
						local server_configurations = servers[server_name] or {}
						server_configurations.capabilities =
								vim.tbl_deep_extend('force', {}, capabilities, server_configurations.capabilities or {})
						require('lspconfig')[server_name].setup(server_configurations)
					end,
				},
			}
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

}
