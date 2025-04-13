-- [[Settings options]]
-- See `:help vim.opt`
-- NOTE: Global settings
--  For more options, you can see `:help option-list`

vim.ui.select = require('mini.files').ui_select
local g = vim.g
-- Hide deprecation warnings
g.deprecated = false
-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

local opt = vim.opt

-- Core Editing XP
opt.autoindent = true
opt.expandtab = true
opt.smarttab = true
opt.backspace = 'indent,eol,start'

-- Visual Cues and Navigation
opt.number = true
opt.cursorline = true
opt.hlsearch = true
opt.incsearch = true
opt.scrolloff = 8

-- Comfort features
opt.mouse = 'a'
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.clipboard = 'unnamedplus'

-- Additional sensible defaults
opt.ignorecase = true
opt.smartcase = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 500

-- Code-Specific Features
vim.cmd 'syntax enable'
opt.smartindent = true
opt.showmatch = true

-- Optional tweaks
vim.opt.laststatus = 2
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.signcolumn = 'yes'

-- List
opt.list = true
opt.listchars = {
  tab = '▶ ', -- Use a right-pointing triangle for tabs
  trail = '•', -- Dots for trailing spaces
  extends = '➔', -- Arrow for lines that extend beyond the window
  precedes = '➔', -- Arrow for lines that precede the window
  nbsp = '␣', -- Special character for non-breaking spaces
  lead = ' ', -- No special character for leading spaces
  multispace = '·', -- Dots for multiple spaces (if desired)
}
