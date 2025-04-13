local M = {}
M.initialized = false
M.config = {
  window = {
    config = {
      border = 'none',
      anchor = 'NW',
      height = math.floor(0.618 * vim.o.lines),
      width = math.floor(0.618 * vim.o.columns),
      row = math.floor(0.5 * (vim.o.lines - math.floor(0.618 * vim.o.lines))),
      col = math.floor(0.5 * (vim.o.columns - math.floor(0.618 * vim.o.columns))),
    },
  },
}

M.get = function()
  local MiniPick = require 'mini.pick'

  if not M.initialized then
    MiniPick.setup(M.config)
    vim.ui.select = MiniPick.ui_select
    M.initialized = true
  end

  return MiniPick
end

return M
