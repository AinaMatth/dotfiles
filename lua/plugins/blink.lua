return {
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
    'folke/lazydev.nvim',
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      nerd_font_variant = 'normal',
    },
    completion = {
      ghost_text = {
        enabled = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = 'single',
          desired_min_width = 30,
        },
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    signature = { enabled = true },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
