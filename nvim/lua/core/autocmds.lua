-- Highlight text on Yank

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.hl.on_yank { higroup = highlight_group, pattern = '*', timeout = 300 }
	end,
})

-- close some filetypes with <q>
local close_group = vim.api.nvim_create_augroup('close_with_q', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"checkhealth",
		"help",
		"lspinfo",
		"startuptime",
		"telescope",
	},
	group = close_group,
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})
