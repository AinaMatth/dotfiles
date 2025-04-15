vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.snacks_animate = true
vim.g.have_nerd_font = true
vim.g.deprecation_warnings = false
vim.o.termguicolors = true
vim.o.completeopt = 'menu,menuone,popup,fuzzy'

vim.schedule(function()
  vim.opt.clipboard:append 'unnamedplus'
end)

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.timeoutlen = 300
vim.opt.pumheight = 10
vim.opt.ignorecase = true
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true -- Put new windows right of current
vim.opt.wildmode = 'longest:full,full'
vim.opt.smartcase = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.list = true
vim.opt.listchars = {
  tab = '▶ ',
  trail = '·',
  extends = '»',
  precedes = '«',
}
vim.opt.diffopt:append 'linematch:60'
vim.opt.confirm = true
vim.opt.updatetime = 200
vim.opt.smartindent = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.o.statuscolumn = ''
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.g.netrw_banner = 0
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5
vim.opt.redrawtime = 100
vim.opt.history = 200
vim.diagnostic.config {
  virtual_lines = { current_line = true },
  underline = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
}
