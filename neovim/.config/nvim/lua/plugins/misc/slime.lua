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

    map('n', '<leader>sl', '<Plug>SlimeLineSend', opts)
    map('v', '<leader>ss', '<Plug>SlimeRegionSend', opts)
    map('v', '<leader>sc', '<Plug>SlimeSendCell', opts)
    map('v', '<leader>sm', '<Plug>SlimeMotionSend', opts)
  end,
}
