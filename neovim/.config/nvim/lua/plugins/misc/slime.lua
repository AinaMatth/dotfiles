return {
  'jpalardy/vim-slime',
  config = function()
    vim.g.slime_target = 'tmux'
    vim.g.slime_default_config = {
      socket_name = 'default',
      target_pane = '{last}',
    }
    vim.g.slime_bracketed_paste = 1
    vim.api.nvim_set_var('slime_no_mappings', 1)
    vim.g.slime_cell_delimiter = '```'
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map('n', '<leader>cl', '<Plug>SlimeLineSend', opts)
    map('v', '<leader>cs', '<Plug>SlimeRegionSend', opts)
    map('v', '<leader>cc', '<Plug>SlimeSendCell', opts)
    map('v', '<leader>cm', '<Plug>SlimeMotionSend', opts)
    map('n', '<leader>rl', '<cmd>SlimeSend1 ls()<CR>', opts)
    map('n', '<leader>rq', '<cmd>SlimeSend1 q()<CR>', opts)
    map('n', '<leader>rr', '<cmd>SlimeSend1 rm(list = ls())<CR>', opts)
  end,
}
