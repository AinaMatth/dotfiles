return {
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
        ['<c-y>'] = { 'show_documentation', 'hide_documentation' },
      },
      appearance = {
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
        default = { 'lsp', 'path', 'snippets', 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      cmdline = {
        enabled = false,
      },
    },
    opts_extend = {
      'sources.default',
    },
  },
}
