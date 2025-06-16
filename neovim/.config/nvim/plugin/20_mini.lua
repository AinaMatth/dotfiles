local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
add { name = 'mini.nvim', checkout = 'HEAD' }

now(function()
  require('mini.base16').setup {
    palette = {
      base00 = '#0d1117',
      base01 = '#0d1117',
      base02 = '#30363d',
      base03 = '#484f58',
      base04 = '#8b949e',
      base05 = '#c9d1d9',
      base06 = '#f0f6fc',
      base07 = '#ffffff',
      base08 = '#ff7b72',
      base09 = '#d2a8ff',
      base0A = '#f9e2af',
      base0B = '#7ce38b',
      base0C = '#89ddff',
      base0D = '#79c0ff',
      base0E = '#ffa657',
      base0F = '#ffc4d4',
    },
    use_cterm = true,
    plugins = { default = true, ['echasnovski/mini.nvim'] = true },
  }
end)

now(function()
  require('mini.icons').setup {}
  later(MiniIcons.mock_nvim_web_devicons)
  later(MiniIcons.tweak_lsp_kind)
end)

now(function()
  local statusline = require 'mini.statusline'
  statusline.setup { use_icons = vim.g.have_nerd_font }
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return '%2l:%-2v'
  end
  vim.opt.laststatus = 3
  vim.opt.cmdheight = 0
end)

now(function()
  require('mini.notify').setup {}
  vim.notify = MiniNotify.make_notify { ERROR = { duration = 10000 } }
  vim.api.nvim_create_user_command('NotifyHistory', function()
    MiniNotify.show_history()
  end, { desc = 'Show notify history' })
end)

now(function()
  require('mini.misc').setup()
  MiniMisc.setup_restore_cursor()
  MiniMisc.setup_auto_root()
  MiniMisc.setup_termbg_sync()
  vim.api.nvim_create_user_command('Zoom', function()
    MiniMisc.zoom(0, {})
  end, { desc = 'Zoom current buffer' })
end)

-- Later
later(function()
  require('mini.extra').setup()
end)
later(function()
  require('mini.bufremove').setup()
end)
later(function()
  local animate = require 'mini.animate'
  animate.setup {
    cursor = { timing = animate.gen_timing.linear { duration = 100, unit = 'total' } },
    scroll = { timing = animate.gen_timing.linear { duration = 150, unit = 'total' } },
  }
end)
later(function()
  local hipatterns = require 'mini.hipatterns'
  local hi_words = require('mini.extra').gen_highlighter.words
  hipatterns.setup {
    highlighters = {
      fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  }
end)
later(function()
  require('mini.indentscope').setup {
    symbol = '│',
    options = { try_as_border = true },
  }
end)
later(function()
  require('mini.tabline').setup()
end)
later(function()
  vim.api.nvim_create_user_command('Bufdelete', function()
    MiniBufremove.delete()
  end, { desc = 'Remove buffer' })
end)
later(function()
  require('mini.trailspace').setup()
  vim.api.nvim_create_user_command('Trim', function()
    MiniTrailspace.trim()
    MiniTrailspace.trim_last_lines()
  end, { desc = 'Trim trailing space and last blank lines' })
end)
later(function()
  require('mini.pairs').setup()
end)
later(function()
  require('mini.surround').setup()
end)
later(function()
  local ai = require 'mini.ai'
  local gen_ai_spec = require('mini.extra').gen_ai_spec
  ai.setup {
    n_lines = 500,
    custom_textobjects = {
      B = gen_ai_spec.buffer(),
      D = gen_ai_spec.diagnostic(),
      I = gen_ai_spec.indent(),
      L = gen_ai_spec.line(),
      N = gen_ai_spec.number(),
      J = { { '()%d%d%d%d%-%d%d%-%d%d()', '()%d%d%d%d%/%d%d%/%d%d()' } },
    },
  }
end)
later(function()
  require('mini.fuzzy').setup()
  require('mini.completion').setup {
    lsp_completion = {
      source_func = 'omnifunc',
      process_items = MiniFuzzy.process_lsp_items,
    },
  }
  local on_attach = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end
  vim.api.nvim_create_autocmd('LspAttach', { callback = on_attach })
  if vim.fn.has 'nvim-0.11' == 1 then
    vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
  end
  vim.opt.complete = { '.', 'w', 'k', 'b', 'u' }
  vim.opt.completeopt:append 'fuzzy'
  local keys = {
    cn = vim.keycode '<c-n>',
    cp = vim.keycode '<c-p>',
    ct = vim.keycode '<c-t>',
    cd = vim.keycode '<c-d>',
    cr = vim.keycode '<cr>',
    cy = vim.keycode '<c-y>',
  }
  vim.keymap.set('i', '<tab>', function()
    return vim.fn.pumvisible() == 1 and keys.cn or keys.ct
  end, { expr = true, desc = 'Select next item if popup is visible' })
  vim.keymap.set('i', '<s-tab>', function()
    return vim.fn.pumvisible() == 1 and keys.cp or keys.cd
  end, { expr = true, desc = 'Select previous item if popup is visible' })
  vim.keymap.set('i', '<cr>', function()
    if vim.fn.pumvisible() == 0 then
      return require('mini.pairs').cr()
    end
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    if item_selected then
      return keys.cy
    end
    return keys.cy .. keys.cr
  end, { expr = true, desc = 'Complete current item if item is selected' })
  local gen_loader = require('mini.snippets').gen_loader
  require('mini.snippets').setup {
    snippets = {
      gen_loader.from_file '~/.config/nvim/snippets/global.json',
      gen_loader.from_lang(),
    },
  }
end)
later(function()
  require('mini.files').setup { windows = { preview = true } }
end)
later(function()
  require('mini.diff').setup {
    view = {
      style = 'sign',
      signs = {
        add = '▎',
        change = '▎',
        delete = '',
      },
    },
  }
  require('mini.git').setup()
end)
later(function()
  require('mini.jump').setup { delay = { idle_stop = 10 } }
end)
later(function()
  require('mini.jump2d').setup()
end)
later(function()
  require('mini.bracketed').setup()
end)
later(function()
  local map = require 'mini.map'
  map.setup {
    integrations = {
      map.gen_integration.builtin_search(),
      map.gen_integration.diff(),
      map.gen_integration.diagnostic(),
    },
    symbols = { scroll_line = '▶' },
  }
  vim.keymap.set('n', '<leader>tf', MiniMap.toggle_focus, { desc = 'MiniMap.toggle_focus' })
  vim.keymap.set('n', '<leader>ts', MiniMap.toggle_side, { desc = 'MiniMap.toggle_side' })
  vim.keymap.set('n', '<leader>tt', MiniMap.toggle, { desc = 'MiniMap.toggle' })
end)
