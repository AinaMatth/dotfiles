vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.cmd.colorscheme 'habamax'
vim.o.completeopt = 'menu,menuone,popup,fuzzy'

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.schedule(function()
  vim.opt.clipboard:append 'unnamedplus'
end)

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.timeoutlen = 300
vim.opt.pumheight = 10
vim.opt.ignorecase = true
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
  eob = ' ',
  foldopen = '▾',
  foldclose = '▸',
}
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5
vim.opt.redrawtime = 100
vim.opt.history = 200
vim.diagnostic.config {
  virtual_lines = true,
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
