vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})
-- show cursor line only in active window
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('kickstart-close-files', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuOpen',
  callback = function()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuClose',
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

local function quarto_preview_in_split()
  local filepath = vim.fn.expand '%:p' -- full path to current file
  local filename = vim.fn.expand '%:t' -- just the file name
  local filedir = vim.fn.expand '%:p:h' -- directory

  if not filepath:match '%.qmd$' then
    vim.notify('Not a .qmd file', vim.log.levels.WARN)
    return
  end

  -- Open terminal split
  vim.cmd 'belowright split | resize 15'

  -- Run: cd to file's dir, then preview the file
  local cmd = string.format('cd "%s" && quarto preview "%s"', filedir, filename)
  vim.cmd('terminal ' .. cmd)

  -- Focus into terminal
  vim.cmd 'startinsert'
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'quarto',
  callback = function()
    vim.keymap.set('n', '<leader>qp', quarto_preview_in_split, {
      buffer = true,
      desc = 'Quarto Preview in Terminal',
    })
  end,
})
