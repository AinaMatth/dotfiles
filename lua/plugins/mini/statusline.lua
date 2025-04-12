local M = {}

M.config = {
  content = {
    active = function()
      local mode, mode_hl = require('mini.statusline').section_mode { trunc_width = 120 }
      local git = require('mini.statusline').section_git { trunc_width = 40 }
      local diff = require('mini.statusline').section_diff { trunc_width = 75 }
      local diagnostics = require('mini.statusline').section_diagnostics { trunc_width = 75 }
      local lsp = require('mini.statusline').section_lsp { trunc_width = 75 }
      local filename = require('mini.statusline').section_filename { trunc_width = 140 }
      local fileinfo = require('mini.statusline').section_fileinfo { trunc_width = 120 }
      local position = string.format('Line %d:%d', vim.fn.line '.', vim.fn.col '.')
      return require('mini.statusline').combine_groups {
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diff } },
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%<', -- Mark truncate point
        '%=', -- End left alignment
        { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics, lsp } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { position } },
      }
    end,

    inactive = function()
      local filename = require('mini.statusline').section_filename { trunc_width = 140 }
      return require('mini.statusline').combine_groups {
        { hl = 'MiniStatuslineInactive', strings = { filename } },
      }
    end,
  },
  use_icons = true,
  set_vim_settings = true,
}

return M
