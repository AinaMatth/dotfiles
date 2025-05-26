return {
  {
    'jmbuhr/otter.nvim',
    dev = false,
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
      },
    },
    config = function()
      local otter = require 'otter'
      otter.setup {
        buffers = {
          write_to_disk = true,
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_pending = ' ',
              package_installed = ' ',
              package_uninstalled = ' ',
            },
          },
          max_concurrent_installers = 10,
        },
      },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
          map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
          map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, '[W]orkspace [S]ymbols')
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        end,
      })
      -- ============================================================================
      -- Diagnostic Configuration
      -- ============================================================================

      vim.diagnostic.config {
        severit_sort = true,
        virtual_lines = { current_line = true },
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '󰌵',
          },
        },
      }
      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }
      local capabilities = require('blink.cmp').get_lsp_capabilities({}, true)
      local servers = {
        air = {
          flags = lsp_flags,
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end,
        },
        clangd = {
          flags = lsp_flags,
          capabilities = capabilities,
        },
        ruff = {
          lsp_flags = lsp_flags,
          capabilities = capabilities,
        },
        basedpyright = {
          lsp_flags = lsp_flags,
          capabilities = capabilities,
        },
        rust_analyzer = {
          lsp_flags = lsp_flags,
          capabilities = capabilities,
        },
        r_language_server = {
          lsp_flags = lsp_flags,
          capabilities = capabilities,
          filetypes = { 'r', 'rmd', 'rmarkdown' },
          settings = {
            r = {
              lsp = {
                rich_documentation = true,
              },
            },
          },
          on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
        vtsls = {
          flags = lsp_flags,
          capabilities = capabilities,
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
        },
        lua_ls = {
          lsp_flags = lsp_flags,
          capabilities = capabilities,
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              format = { enable = false },
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                disable = { 'trailing-space' },
                globals = { 'vim' },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'ruff',
        'prettier',
        'prettierd',
        'clang-format',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
