return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = true, -- Load on demand

  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "regex",
        "python",
        "javascript",
        "typescript",
        "rust",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    })
  end,

  event = { "BufReadPost", "BufNewFile" }, -- Trigger config after buffer is loaded
}
