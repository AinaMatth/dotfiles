-- ============================================================================
-- Neovim Global Variables and Options Setup
-- ============================================================================

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Global flags
vim.g.have_nerd_font = true
vim.g.deprecation_warnings = false
vim.g.netrw_banner = 0
-- ============================================================================
-- Core Vim Options
-- ============================================================================

local opt = vim.opt
local o = vim.o

-- UI / Interface
o.termguicolors = true
o.showmode = false
opt.mouse = 'a'
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.statuscolumn = ''
opt.laststatus = 3
opt.ruler = false
opt.scrolloff = 8
opt.sidescrolloff = 5
opt.redrawtime = 100

-- Completion and Popup
o.completeopt = 'menu,menuone,popup,fuzzy'
opt.pumblend = 10
opt.pumheight = 10

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Clipboard (use schedule to ensure GUI-safe)
vim.schedule(function()
  opt.clipboard:append 'unnamedplus'
end)

-- Indentation
opt.smartindent = true
opt.breakindent = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true

-- Split behavior
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = 'screen'

-- UI symbols and formatting
opt.wildmode = 'longest:full,full'
opt.list = true
opt.listchars = {
  tab = '▶ ',
  trail = '·',
  extends = '»',
  precedes = '«',
}
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

-- Misc
o.inccommand = 'split'
opt.virtualedit = 'block'
opt.timeoutlen = 300
opt.confirm = true
opt.updatetime = 200
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.history = 200
