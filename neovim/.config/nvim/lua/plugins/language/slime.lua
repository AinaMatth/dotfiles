return {
  'jpalardy/vim-slime',
  init = function()
    vim.g.slime_target = 'tmux'
    vim.g.slime_default_config = {
      socket_name = 'default',
      target_pane = '{last}',
    }
    vim.g.slime_bracketed_paste = 1
  end,
}
