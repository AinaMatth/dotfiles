-- NOTE: lua/config/lsp.lua
local M = {}

function M.setup()
	-- NOTE: Autocommand for LSP attachment
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("LspAttachGroup", { clear = true }),
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client then
				return
			end

			-- Key mappings for LSP features
			local function map_key(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
			end

			if client:supports_method("textDocument/implementation") then
				map_key("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			end

			if client:supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = args.buf,
					callback = function()
						vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
					end,
				})
			end
		end,
	})

	-- NOTE: Diagnostic configuration
	local icons = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
	vim.diagnostic.config({
		virtual_text = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icons.Error,
				[vim.diagnostic.severity.WARN] = icons.Warn,
				[vim.diagnostic.severity.HINT] = icons.Hint,
				[vim.diagnostic.severity.INFO] = icons.Info,
			},
		},
		underline = true,
		update_in_insert = false,
		severity_sort = false,
	})

	local function on_attach(client, bufnr)
		print("Attached to PHP buffer")
	end
	-- NOTE: Setup capabilities for LSP clients
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

	-- NOTE: LSP servers configuration
	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							completion = {
								callSnippet = "Replace",
							},
							telemetry = { enable = false },
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
			},
		},
		bashls = {},
		cssls = {},
		basedpyright = {
			root_dir = function(...)
				return require("lspconfig.util").root_pattern(".git")(...)
			end,
		},
		-- ts_ls = {
		-- 	init_options = {
		-- 		plugins = {
		-- 			{
		-- 				name = "@vue/typescript-plugin",
		-- 				location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
		-- 				languages = { "javascript", "typescript", "vue" },
		-- 			},
		-- 		},
		-- 	},
		-- 	root_dir = function(...)
		-- 		return require("lspconfig.util").root_pattern(".git")(...)
		-- 	end,
		-- 	filetypes = {
		-- 		"javascript",
		-- 		"typescript",
		-- 		"vue",
		-- 	},
		-- },
		html = {},
		tailwindcss = {
			root_dir = function(...)
				return require("lspconfig.util").root_pattern(".git")(...)
			end,
		},
		vimls = {},
		phpactor = {
			on_attach = on_attach,
			root_dir = function(fname)
				return vim.fn.getcwd()
			end,
			init_options = {
				["language_server_phpstan.enabled"] = false,
				["language_server_psalm.enabled"] = false,
			},
		},
	}

	-- NOTE: Mason setup
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, { "stylua", "black", "isort", "prettier", "prettierd", "eslint_d", "pylint" })
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	require("mason-lspconfig").setup({
		ensure_installed = {},
		automatic_installation = false,
		handlers = {
			function(server_name)
				local server_configurations = servers[server_name] or {}
				server_configurations.capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, server_configurations.capabilities or {})
				require("lspconfig")[server_name].setup(server_configurations)
			end,
		},
	})
end

return M
