return {
  'echasnovski/mini.indentscope',
  opts = {
    symbol = '│',
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'alpha',
        'fzf',
        'help',
        'lazy',
        'mason',
        'oil',
        'notify',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
