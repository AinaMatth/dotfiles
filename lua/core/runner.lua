-- core/runner.lua
-- Enhanced Neovim code runner for multiple languages

local M = {}

-- Default configuration
local config = {
  languages = {
    c = {
      build_cmd = function(fullpath, dir, name, flags)
        return string.format('cd %s && gcc %s -o %s %s', dir, fullpath, name, flags)
      end,
      run_cmd = function(dir, name)
        return string.format('cd %s && ./%s', dir, name)
      end,
      clean_cmd = function(dir, name)
        return string.format('cd %s && rm %s', dir, name)
      end,
    },
    rust = {
      build_cmd = function(fullpath, dir, name)
        return string.format('cd %s && rustc %s -o %s', dir, fullpath, name)
      end,
      run_cmd = function(dir, name)
        return string.format('cd %s && ./%s', dir, name)
      end,
      clean_cmd = function(dir, name)
        return string.format('cd %s && rm %s', dir, name)
      end,
    },
    python = { cmd = 'python3 %' },
    javascript = { cmd = 'node %' },
    lua = { cmd = 'lua %' },
    r = { cmd = 'Rscript %' }, -- ADDED R SUPPORT HERE!
  },
  float = {
    border = 'rounded',
    width = 80,
    height = 20,
    win_opts = { winblend = 10 },
  },
  close_key = 'q',
}

-- Setup function
function M.setup(user_config)
  config = vim.tbl_deep_extend('force', config, user_config or {})
  vim.keymap.set('n', '<leader>cr', M.run, { silent = true, desc = 'Run code in float' })
  vim.keymap.set('n', '<leader>cq', M.close, { silent = true, desc = 'Close code runner' })
end

-- Build, run, and clean for compiled languages
local function build_run_clean(lang, fullpath, dir, name, ft, start_time)
  local build_cmd
  if ft == 'c' then
    local flags = vim.fn.input('C flags (e.g. -lcs50 -lm): ', '-lcs50 ')
    build_cmd = lang.build_cmd(fullpath, dir, name, flags)
  else
    build_cmd = lang.build_cmd(fullpath, dir, name)
  end

  local function exec_in_term(cmd, on_exit)
    local buf = vim.api.nvim_create_buf(false, true)
    local h, w = config.float.height, config.float.width
    local row = math.floor((vim.o.lines - h) / 2 - 1)
    local col = math.floor((vim.o.columns - w) / 2)
    local win = vim.api.nvim_open_win(buf, true, {
      style = 'minimal',
      relative = 'editor',
      row = row,
      col = col,
      width = w,
      height = h,
      border = config.float.border,
    })

    vim.fn.termopen(cmd, {
      on_exit = function(_, code)
        if on_exit then
          on_exit(code, win)
        end
      end,
    })

    vim.api.nvim_command 'startinsert'
    vim.api.nvim_buf_set_option(buf, 'buflisted', false)
    vim.keymap.set('t', config.close_key, [[<C-\><C-n>:bd!<CR>]], { buffer = buf, silent = true })
    vim.keymap.set('n', config.close_key, '<cmd>bd!<CR>', { buffer = buf, silent = true })

    return buf, win
  end

  exec_in_term(build_cmd, function(code, win)
    if code ~= 0 then
      vim.notify('Build failed (see terminal)', vim.log.levels.ERROR)
      return
    end
    vim.api.nvim_win_close(win, true)

    local input_file = vim.fn.input 'Input file for stdin (empty for none): '
    local run_cmd = lang.run_cmd(dir, name)
    if input_file ~= '' then
      run_cmd = run_cmd .. ' < ' .. input_file
    end

    M._open_term_and_execute(run_cmd)

    os.execute(lang.clean_cmd(dir, name))

    local elapsed = (vim.loop.hrtime() - start_time) / 1e6
    vim.notify(string.format('Finished in %.2f ms', elapsed))
  end)
end

-- Main run function
function M.run()
  vim.cmd 'w' -- Save first
  local start_time = vim.loop.hrtime()
  local ft = vim.bo.filetype
  local lang = config.languages[ft]
  if not lang then
    vim.notify('No runner for ' .. ft, vim.log.levels.ERROR)
    return
  end

  local fullpath = vim.fn.expand '%:p'
  local dir = vim.fn.expand '%:p:h'
  local name = vim.fn.expand '%:t:r'

  if ft == 'c' or ft == 'rust' then
    build_run_clean(lang, fullpath, dir, name, ft, start_time)
  else
    local cmd = lang.cmd:gsub('%%', fullpath)
    M._open_term_and_execute(cmd)
  end
end

-- Open floating terminal
function M._open_term_and_execute(cmd)
  local buf = vim.api.nvim_create_buf(false, true)
  local h, w = config.float.height, config.float.width
  local row = math.floor((vim.o.lines - h) / 2 - 1)
  local col = math.floor((vim.o.columns - w) / 2)
  vim.api.nvim_open_win(buf, true, {
    style = 'minimal',
    relative = 'editor',
    row = row,
    col = col,
    width = w,
    height = h,
    border = config.float.border,
  })

  vim.fn.termopen(cmd)
  vim.api.nvim_command 'startinsert'
  vim.api.nvim_buf_set_option(buf, 'buflisted', false)
  vim.keymap.set('t', config.close_key, [[<C-\><C-n>:bd!<CR>]], { buffer = buf, silent = true })
  vim.keymap.set('n', config.close_key, '<cmd>bd!<CR>', { buffer = buf, silent = true })
end

-- Close floating manually
function M.close()
  vim.cmd 'bd!'
end

return M
