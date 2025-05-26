return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '*',
    build = 'cargo build --release',
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'fang2hou/blink-copilot' },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<c-y>'] = { 'select_and_accept' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'normal',
      },
      completion = {
        ghost_text = {
          enabled = true,
          show_with_selection = true,
          show_with_menu = true,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          treesitter_highlighting = true,
          window = { border = 'rounded' },
        },
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true },
      cmdline = {
        enabled = false,
      },
    },
    opts_extend = {
      'sources.default',
    },
  },
}
