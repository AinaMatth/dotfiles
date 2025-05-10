local hide_in_width = function()
  return vim.fn.winwidth(0) > 100
end

local mode = {
  'mode',
  fmt = function(str)
    return ' ' .. str
  end,
}

local filename = {
  'filename',
  file_status = true,
  path = 0,
  symbols = {
    modified = ' [+]',
    readonly = ' ',
    unnamed = ' [No Name]',
    newfile = ' [New]',
  },
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  colored = true,
  update_in_insert = false,
  always_visible = false,
  cond = hide_in_width,
}

local diff = {
  'diff',
  symbols = { added = ' ', modified = ' ', removed = ' ' },
  colored = true,
  cond = hide_in_width,
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'echasnovski/mini.icons',
  },
  config = function()
    require('mini.icons').setup { use_as_default = true }
    require('mini.icons').mock_nvim_web_devicons()

    require('lualine').setup {
      options = {
        theme = 'catppuccin',
        icons_enabled = true,
        component_separators = '',
        section_separators = '',
        disabled_filetypes = { 'alpha', 'NvimTree' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = {
          diagnostics,
          diff,
          { 'encoding', cond = hide_in_width },
          { 'filetype', cond = hide_in_width },
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fzf', 'quickfix', 'man', 'nvim-tree' },
    }
  end,
}
