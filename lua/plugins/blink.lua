-- -- Autocompletion
return {
  'saghen/blink.cmp',
  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  event = 'InsertEnter',
  version = '*',
  build = 'cargo build --release',

  ---@module 'blink.cmp'
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = { documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = 'single' } } },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
