local M = {}

-- ── Highlight Definitions ───────────────────────────────────────────────────
local hl = vim.api.nvim_set_hl
local get_hl = vim.api.nvim_get_hl

-- Utility to copy highlight group and disable italic
local function copy_and_clean_hl(src, dst)
  local ok, def = pcall(get_hl, 0, { name = src, link = false })
  if ok and def then
    def.italic = false
    hl(0, dst, def)
  end
end

-- Force non-italic base highlights
hl(0, 'StatusLine', { italic = false })
hl(0, 'StatusLineNC', { italic = false })
copy_and_clean_hl('Type', 'StlGit')
copy_and_clean_hl('Keyword', 'StlFile')
copy_and_clean_hl('DiagnosticWarn', 'StlDiag')

-- Dynamic mode highlights
local mode_hl_map = {
  n = { group = 'StlMode', link = 'Normal' },
  i = { group = 'StlMode', link = 'Insert' },
  v = { group = 'StlMode', link = 'Visual' },
  V = { group = 'StlMode', link = 'Visual' },
  ['\22'] = { group = 'StlMode', link = 'Visual' },
  c = { group = 'StlMode', link = 'Command' },
  R = { group = 'StlMode', link = 'Replace' },
  t = { group = 'StlMode', link = 'Terminal' },
}

-- Use fg color instead of bg for transparent schemes
local function set_mode_color()
  local mode = vim.api.nvim_get_mode().mode
  local def = mode_hl_map[mode]
  if def then
    local ok, hl_def = pcall(get_hl, 0, { name = def.link, link = true })
    if ok and hl_def and hl_def.fg then
      hl(0, def.group, { fg = hl_def.fg, italic = false })
    end
    return '%#' .. def.group .. '#'
  end
  return '%#StatusLine#'
end

-- ── Mode Text ───────────────────────────────────────────────────────────────
local mode_map = {
  n = 'NORMAL',
  i = 'INSERT',
  v = 'VISUAL',
  V = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  c = 'COMMAND',
  R = 'REPLACE',
  t = 'TERMINAL',
}
local function mode_text()
  return mode_map[vim.api.nvim_get_mode().mode] or 'UNKNOWN'
end

-- ── Git Info ────────────────────────────────────────────────────────────────
local function git()
  local g = vim.b.gitsigns_status_dict
  if not g then
    return ''
  end
  local parts = {
    g.head and ' ' .. g.head or nil,
    g.added and g.added > 0 and ' ' .. g.added or nil,
    g.changed and g.changed > 0 and ' ' .. g.changed or nil,
    g.removed and g.removed > 0 and ' ' .. g.removed or nil,
  }
  return table.concat(
    vim.tbl_filter(function(v)
      return v
    end, parts),
    ' '
  )
end

-- ── File Info ───────────────────────────────────────────────────────────────
local function file()
  local name = vim.fn.expand '%:t'
  name = name ~= '' and name or '[No Name]'
  local ext = vim.fn.expand '%:e'
  local icon = require('nvim-web-devicons').get_icon(name, ext, { default = true }) or ''
  local readonly = vim.bo.readonly and ' ' or ''
  local modified = vim.bo.modified and ' ' or ''
  return icon .. ' ' .. name .. readonly .. modified
end

local function filetype()
  return vim.bo.filetype
end

-- ── Diagnostics ─────────────────────────────────────────────────────────────
local function diagnostics()
  local function count(severity)
    return #vim.diagnostic.get(0, { severity = severity })
  end
  local parts = {
    count(vim.diagnostic.severity.ERROR) > 0 and (' ' .. count(vim.diagnostic.severity.ERROR)) or nil,
    count(vim.diagnostic.severity.WARN) > 0 and (' ' .. count(vim.diagnostic.severity.WARN)) or nil,
  }
  return table.concat(
    vim.tbl_filter(function(v)
      return v
    end, parts),
    ' '
  )
end

-- ── LSP Clients ─────────────────────────────────────────────────────────────
local function lsp_clients()
  local clients = vim.lsp.get_active_clients { bufnr = 0 }
  if #clients == 0 then
    return ''
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return ' ' .. table.concat(names, ', ')
end

-- ── Cursor Location ─────────────────────────────────────────────────────────
local function position()
  local l, c = vim.fn.line '.', vim.fn.col '.'
  local total = math.max(vim.fn.line '$', 1)
  local percent = math.floor((l / total) * 100)
  return string.format('%3d:%-2d %2d%%%%', l, c, percent)
end

-- ── Compose Statusline ──────────────────────────────────────────────────────
function M.statusline()
  return table.concat {
    set_mode_color(),
    ' ',
    mode_text(),
    ' ',
    '%#StlGit#',
    git(),
    ' ',
    '%#StlFile#',
    file(),
    ' [',
    filetype(),
    '] ',
    '%#StatusLine#',
    lsp_clients(),
    ' ',
    '%=', -- right align
    '%#StlDiag#',
    diagnostics(),
    ' ',
    '%#StatusLine#',
    position(),
    ' ',
  }
end

vim.o.statusline = "%!v:lua.require'core.statusline'.statusline()"
return M
