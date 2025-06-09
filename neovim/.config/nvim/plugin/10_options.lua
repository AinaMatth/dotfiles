-- Neovim Global Variables and Options Setup

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Global flags
vim.g.have_nerd_font = true
vim.g.deprecation_warnings = false
vim.g.netrw_banner = 0

-- Core Vim Options

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
opt.scrolloff = 4
opt.sidescrolloff = 5
opt.redrawtime = 100
opt.conceallevel = 2
opt.shortmess:append { W = true, I = true, c = true, C = true }

-- Completion and Popup
o.completeopt = 'menu,menuone,noselect'
opt.pumblend = 10

opt.pumheight = 10

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'

-- Indentation
opt.smartindent = true
opt.breakindent = true
opt.shiftround = true
opt.shiftwidth = 2

opt.tabstop = 2
opt.expandtab = true
opt.linebreak = true

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
o.inccommand = 'nosplit'
opt.virtualedit = 'block'
opt.jumpoptions = 'view'
opt.timeoutlen = 300
opt.confirm = true
opt.updatetime = 200
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.history = 200
