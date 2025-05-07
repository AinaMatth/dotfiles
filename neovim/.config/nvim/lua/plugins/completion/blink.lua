return {
  {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    version = '1.*',
    build = 'cargo build --release',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            { path = 'snacks.nvim', words = { 'Snacks' } },
          },
        },
      },
      { 'fang2hou/blink-copilot' },
      { 'R-nvim/cmp-r' },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        nerd_font_variant = 'normal',
      },
      completion = {
        menu = {
          border = 'rounded',
          scrollbar = false,
        },
        ghost_text = {
          enabled = true,
          show_with_selection = true,
          show_with_menu = true,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = { border = 'rounded' },
        },
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'cmp_r', 'copilot' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          cmp_r = {
            name = 'cmp_r',
            module = 'blink.compat.source',
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
      snippets = { preset = 'luasnip' },
      signature = { enabled = true, window = { border = 'rounded' } },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
  },
}
