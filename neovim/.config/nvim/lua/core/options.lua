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
opt.cursorline = true
opt.number = true
opt.signcolumn = 'yes'
opt.statuscolumn = ''
opt.laststatus = 3
opt.showmode = false
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
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'

-- Clipboard (use schedule to ensure GUI-safe)
vim.schedule(function()
  opt.clipboard:append 'unnamedplus'
end)

-- Indentation
opt.smartindent = true
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
opt.virtualedit = 'block'
opt.timeoutlen = 300
opt.confirm = true
opt.updatetime = 200
opt.undofile = true
opt.undolevels = 10000
opt.history = 200

-- ============================================================================
-- Statusline
-- ============================================================================

local function shorten_path(path, max_len)
  if #path <= max_len then
    return path
  end
  local parts = vim.split(path, '/')
  for i = 1, #parts - 1 do
    parts[i] = parts[i]:sub(1, 1)
    local short = table.concat(parts, '/')
    if #short <= max_len then
      return short
    end
  end
  return table.concat(parts, '/')
end

local function file_path()
  local path = vim.fn.expand '%:~:.'
  if path == '' then
    return '[No Name]'
  end
  return shorten_path(path, 40)
end

local function diagnostics_status()
  local icons = { Error = ' ', Warn = ' ', Info = ' ', Hint = ' ' }
  local counts = { Error = 0, Warn = 0, Info = 0, Hint = 0 }

  for _, d in ipairs(vim.diagnostic.get(0)) do
    for k in pairs(counts) do
      if d.severity == vim.diagnostic.severity[k:upper()] then
        counts[k] = counts[k] + 1
      end
    end
  end

  local parts = {}
  for k, v in pairs(counts) do
    if v > 0 then
      local hl = '%#Status' .. k .. '#'
      table.insert(parts, string.format('%s%s%d%%*', hl, icons[k], v))
    end
  end
  return table.concat(parts, ' ')
end

local function gitsigns_status()
  local gsd = vim.b.gitsigns_status_dict
  if not gsd then
    return ''
  end

  local parts = {}
  if gsd.added and gsd.added > 0 then
    table.insert(parts, string.format('%%#StatusGitAdd#+%d%%*', gsd.added))
  end
  if gsd.changed and gsd.changed > 0 then
    table.insert(parts, string.format('%%#StatusGitChange#~%d%%*', gsd.changed))
  end
  if gsd.removed and gsd.removed > 0 then
    table.insert(parts, string.format('%%#StatusGitRemove#-%d%%*', gsd.removed))
  end

  return table.concat(parts, ' ')
end

local function lsp_status()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients > 0 then
    return 'LSP '
  else
    return ''
  end
end

local function mode_status()
  local modes = {
    n = 'NORMAL',
    i = 'INSERT',
    v = 'VISUAL',
    V = 'V-LINE',
    [''] = 'V-BLOCK',
    c = 'COMMAND',
    R = 'REPLACE',
  }
  local mode = vim.fn.mode()
  local label = modes[mode] or mode
  return string.format('%%#StatusMode# %s %%*', label)
end

vim.api.nvim_set_hl(0, 'StatusMode', { fg = '#7e9cd8', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'StatusError', { fg = '#e46876', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'StatusWarn', { fg = '#ffa066', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'StatusInfo', { fg = '#7fb4ca', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'StatusHint', { fg = '#a6c8a2', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'StatusGitAdd', { fg = '#98bb6c', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'StatusGitChange', { fg = '#7fb4ca', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'StatusGitRemove', { fg = '#e46876', bg = 'NONE' })

function _G.Statusline()
  local left = table.concat({
    mode_status(),
    ' ',
    lsp_status(),
    ' ',
    gitsigns_status(),
    ' ',
    diagnostics_status(),
  }, ' ')

  local right = table.concat {
    file_path(),
    ' %m', -- modified flag
    ' %-14.(%l,%c%V%) %P',
  }

  return left .. '%=' .. right
end

o.statusline = '%!v:lua.Statusline()'
o.laststatus = 3
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    vim.o.statusline = '%!v:lua.Statusline()'
  end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  callback = function()
    vim.o.statusline = '%f'
  end,
})

vim.filetype.add {
  extension = {
    qmd = 'quarto',
  },
}
