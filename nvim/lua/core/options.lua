-- [[Leader key]]
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[Settings options]]
-- See `:help vim.opt`
-- NOTE: Global settings
--  For more options, you can see `:help option-list`

local opt = vim.opt

-- Line number
opt.number = true
opt.relativenumber = true

-- Mouse use
opt.mouse = 'a'

-- Clipboard
opt.clipboard = 'unnamedplus'

-- Window title
opt.title = true

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.shiftround = true
opt.shiftwidth = 2
opt.tabstop = 2

-- Files
opt.fileencoding = 'utf-8'

-- Backup files
opt.backup = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Statusline
opt.laststatus = 3

-- Update time
opt.updatetime = 250

-- Map sequence wait time
opt.timeoutlen = 300

-- Scrolloff
opt.scrolloff = 10

-- Cursor line
opt.cursorline = true

-- List
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } 

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

-- Split
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current

-- Ruler
opt.ruler = false

-- Completion
opt.completeopt = 'menu,menuone,noinsert,fuzzy'
