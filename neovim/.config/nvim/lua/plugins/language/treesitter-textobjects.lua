local function select(textobj)
  return function()
    require('nvim-treesitter-textobjects.select').select_textobject(textobj, 'textobjects')
  end
end

return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  branch = 'main',

  opts = {
    select = {
      lookahead = true,
      include_surrounding_whitespace = false,
    },
  },
  keys = {
    -- TEXT OBJECTS
    { 'a<CR>', select '@return.outer', mode = { 'x', 'o' }, desc = '↩ outer return' },
    { 'i<CR>', select '@return.inner', mode = { 'x', 'o' }, desc = '↩ inner return' },
    { 'a/', select '@regex.outer', mode = { 'x', 'o' }, desc = ' outer regex' },
    { 'i/', select '@regex.inner', mode = { 'x', 'o' }, desc = ' inner regex' },
    { 'aa', select '@parameter.outer', mode = { 'x', 'o' }, desc = '󰏪 outer arg' },
    { 'ia', select '@parameter.inner', mode = { 'x', 'o' }, desc = '󰏪 inner arg' },
    { 'iu', select '@loop.inner', mode = { 'x', 'o' }, desc = '󰛤 inner loop' },
    { 'au', select '@loop.outer', mode = { 'x', 'o' }, desc = '󰛤 outer loop' },
    { 'al', select '@call.outer', mode = { 'x', 'o' }, desc = '󰡱 outer call' },
    { 'il', select '@call.inner', mode = { 'x', 'o' }, desc = '󰡱 inner call' },
    { 'af', select '@function.outer', mode = { 'x', 'o' }, desc = '󰡱 outer function' },
    { 'if', select '@function.inner', mode = { 'x', 'o' }, desc = '󰡱 inner function' },
    { 'ao', select '@conditional.outer', mode = { 'x', 'o' }, desc = '󱕆 outer condition' },
    { 'io', select '@conditional.inner', mode = { 'x', 'o' }, desc = '󱕆 inner condition' },
  },
}
