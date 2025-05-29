return {
  'echasnovski/mini.ai',
  version = false,
  event = 'VeryLazy',
  config = function()
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        b = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' },
        q = { { [["[^"]-"]], [[`[^`]-`]], [[\'[^\']-\']] }, '^.().*().$' },
        t = { { '<(%w-)[^>]->.-</%1>', '<(%w-)[^/>]-/>' }, '^.().*().$' },
        l = { { '^.*().*$' } },
        c = {
          { '```.-```', '~~~.-~~~' },
          '^([`~]{3}[^\n]*\n)().-()\n([`~]{3})$',
        },
      },
    }
  end,
}
