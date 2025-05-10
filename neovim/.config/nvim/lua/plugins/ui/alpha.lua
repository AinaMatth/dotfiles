return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = {
    'echasnovski/mini.icons',
    'nvim-lua/plenary.nvim',
  },
  opts = function()
    local dashboard = require 'alpha.themes.dashboard'
    local logo = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
        ]]
    dashboard.section.header.val = vim.split(logo, '\n')
    dashboard.section.buttons.val = {
      dashboard.button('f', ' ' .. ' Find file', "<cmd>lua require('fzf-lua').files() <cr>"),
      dashboard.button('n', ' ' .. ' New file', '<cmd>ene <BAR> startinsert <cr>'),
      dashboard.button('r', ' ' .. ' Recent files', "<cmd>lua require('fzf-lua').oldfiles() <cr>"),
      dashboard.button('g', ' ' .. ' Find text', "<cmd>lua require('fzf-lua').live_grep() <cr>"),
      dashboard.button(
        'c',
        ' ' .. ' Config',
        "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.stdpath('config') }) <cr>"
      ),
      dashboard.button('l', '󰒲 ' .. ' Lazy', '<cmd>Lazy <cr>'),
      dashboard.button('q', ' ' .. ' Quit', '<cmd>qa <cr>'),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = 'AlphaButtons'
      button.opts.hl_shortcut = 'AlphaShortcut'
    end

    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.section.footer.opts.hl = 'AlphaFooter'
    -- Count total layout height
    local header_lines = #dashboard.section.header.val
    local buttons_lines = #dashboard.section.buttons.val
    local footer_lines = type(dashboard.section.footer.val) == 'table' and #dashboard.section.footer.val or 1
    local total_height = header_lines + buttons_lines + footer_lines + 4 -- includes paddings between

    -- Dynamic top padding to vertically center content
    local win_height = vim.fn.winheight(0)
    local padding_top = math.max(0, math.floor((win_height - total_height) / 2))

    dashboard.opts.layout = {
      { type = 'padding', val = padding_top },
      dashboard.section.header,
      { type = 'padding', val = 1 },
      dashboard.section.buttons,
      { type = 'padding', val = 1 },
      dashboard.section.footer,
    }
    return dashboard
  end,

  config = function(_, dashboard)
    require('alpha').setup(dashboard.opts)

    vim.api.nvim_create_autocmd('User', {
      once = true,
      pattern = 'VimEnter',
      callback = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = '⚡ Neovim loaded '
          .. stats.loaded
          .. '/'
          .. stats.count
          .. ' plugins in '
          .. ms
          .. 'ms'
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
