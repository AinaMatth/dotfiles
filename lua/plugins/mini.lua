return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    local function setup(module, config)
      local ok, mod = pcall(require, 'mini.' .. module)
      if ok and mod and type(mod.setup) == 'function' then
        mod.setup(config or {})
      else
        vim.notify(string.format('Failed to setup mini.nvim module: %s', module), vim.log.levels.WARN)
      end
    end

    -- Setup mini.pairs
    vim.api.nvim_create_autocmd('InsertEnter', {
      pattern = '*',
      callback = function()
        setup('pairs', {
          modes = { insert = true, command = true, terminal = false },
          markdown = true,
        })
      end,
    })

    -- Setup mini.ai
    vim.api.nvim_create_autocmd('InsertEnter', {
      pattern = '*',
      callback = function()
        setup('ai', {
          n_lines = 500,
        })
      end,
    })

    -- Setup mini.git on VimEnter
    vim.api.nvim_create_autocmd('VimEnter', {
      pattern = '*',
      callback = function()
        setup('git', {})
      end,
    })

    -- Setup mini.icons on VimEnter
    vim.api.nvim_create_autocmd('VimEnter', {
      pattern = '*',
      callback = function()
        setup('icons', {
          file = {
            ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
            ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
          },
          filetype = {
            dotenv = { glyph = '', hl = 'MiniIconsYellow' },
            file = {
              ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
              ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
            },
            filetype = {
              dotenv = { glyph = '', hl = 'MiniIconsYellow' },
            },
          },
        })
      end,
    })

    -- Setup mini.statusline on VimEnter
    vim.api.nvim_create_autocmd('VimEnter', {
      pattern = '*',
      callback = function()
        setup('statusline', {
          use_icons = vim.g.have_nerd_font,
          set_vim_settings = false,
          content = {
            active = function()
              ---@global MiniStatusline
              local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
              local git = MiniStatusline.section_git { trunc_width = 40 }
              local diff = MiniStatusline.section_diff { trunc_width = 60 }
              local diagnostics = MiniStatusline.section_diagnostics {
                trunc_width = 60,
              }
              local lsp = MiniStatusline.section_lsp { trunc_width = 40 }
              local filename = MiniStatusline.section_filename { trunc_width = 140 }
              return MiniStatusline.combine_groups {
                { hl = mode_hl,                  strings = { mode:upper() } },
                {
                  hl = 'MiniStatuslineDevinfo',
                  strings = { git, diff },
                },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                {
                  hl = 'MiniStatuslineFileinfo',
                  strings = {
                    vim.bo.filetype ~= ''
                    and require('mini.icons').get('filetype', vim.bo.filetype) .. ' ' .. vim.bo.filetype,
                    diagnostics,
                    lsp,
                  },
                },
                { hl = mode_hl, strings = { '%l:%v' } },
              }
            end,
          },
        })
      end,
    })
  end,
}
