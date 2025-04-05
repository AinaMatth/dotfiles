return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    version = "1.*",
    build = "cargo build --release",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "default" },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = { documentation = { auto_show = false } },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust" },
    },
  },
}
