return {
	'neovim/nvim-lspconfig',
	config = function()
		local lsp = require'lspconfig'
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
	lsp.lua_ls.setup{
	}
	end,
}
