-- [[Settings options]]
-- See `:help vim.opt`
-- NOTE: Global settings
--  For more options, you can see `:help option-list`

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Snacks
vim.g.snacks_animate = true

local opt = vim.opt

-- Wild mode
opt.wildmode = "longest:full,full"

--Gui colors
opt.termguicolors = true

-- Line number
opt.number = true
opt.relativenumber = true

-- Mouse use
opt.mouse = "a"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Window title
opt.title = true

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.shiftround = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

-- Search
opt.ignorecase = true
opt.hlsearch = true

-- Statusline
opt.laststatus = 3

-- Update time
opt.updatetime = 250

-- Map sequence wait time
opt.timeoutlen = 300

-- Scrolloff
opt.scrolloff = 10

-- List
opt.list = true
opt.listchars = {
	tab = "▶ ", -- Use a right-pointing triangle for tabs
	trail = "•", -- Dots for trailing spaces
	extends = "➔", -- Arrow for lines that extend beyond the window
	precedes = "➔", -- Arrow for lines that precede the window
	nbsp = "␣", -- Special character for non-breaking spaces
	lead = " ", -- No special character for leading spaces
	multispace = "·", -- Dots for multiple spaces (if desired)
}

-- Special char
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
-- Tab
opt.smarttab = true

-- Wrap
opt.wrap = false
opt.linebreak = true

-- Split
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current

-- Completion
opt.completeopt = "menu,menuone,noselect,fuzzy"

opt.showmode = false
opt.confirm = true
opt.ruler = false

vim.diagnostic.config({
	virtual_lines = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

-- Easy escape terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
