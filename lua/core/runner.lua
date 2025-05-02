-- core/runner.lua
-- Enhanced Neovim code runner with snippet execution and LSP diagnostics

local M = {}

-- Default configuration
local config = {
  languages = {
    c = {
      build_cmd = function(fullpath, dir, name, flags)
        return string.format('cd %s && gcc %s -o %s %s', dir, fullpath, name, flags or '')
      end,
      run_cmd = function(dir, name)
        return string.format('cd %s && ./%s', dir, name)
      end,
    },
    rust = {
      build_cmd = function(fullpath, dir, name)
        return string.format('cd %s && rustc %s -o %s', dir, fullpath, name)
      end,
      run_cmd = function(dir, name)
        return string.format('cd %s && ./%s', dir, name)
      end,
    },
    python = { cmd = 'python3 %' },
    javascript = { cmd = 'node %' },
    lua = { cmd = 'lua %' },
  },
  float = {
    border = 'rounded',
    width = 80,
    height = 20,
    win_opts = { winblend = 10 },
  },
  close_key = 'q',
}

local diagnostics_ns = vim.api.nvim_create_namespace 'code_runner_diagnostics'

-- Setup function
function M.setup(user_config)
  config = vim.tbl_deep_extend('force', config, user_config or {})
  vim.keymap.set('n', '<leader>cr', M.build_and_run, { silent = true, desc = 'Build and Run code' })
  vim.keymap.set('v', '<leader>cs', M.run_snippet, { silent = true, desc = 'Run code snippet' })
  vim.keymap.set('n', '<leader>cq', M.close, { silent = true, desc = 'Close code runner' })
end

-- Build and run function for compiled languages
function M.build_and_run()
  vim.cmd 'w' -- Save file first
  local start_time = vim.loop.hrtime()
  local ft = vim.bo.filetype
  local lang = config.languages[ft]

  if not lang then
    vim.notify('No runner configured for ' .. ft, vim.log.levels.ERROR)
    return
  end

  local fullpath = vim.fn.expand '%:p'
  local dir = vim.fn.expand '%:p:h'
  local name = vim.fn.expand '%:t:r'

  if not vim.loop.fs_stat(fullpath) then
    vim.notify('File not found: ' .. fullpath, vim.log.levels.ERROR)
    return
  end

  if lang.build_cmd and lang.run_cmd then
    -- Handle compiled languages
    local build_cmd = lang.build_cmd(fullpath, dir, name)
    M._execute_build_and_run(build_cmd, lang.run_cmd, dir, name, start_time)
  elseif lang.cmd then
    -- Handle interpreted languages
    local cmd = lang.cmd:gsub('%%', fullpath)
    M._open_term_and_execute(cmd)
    local elapsed = (vim.loop.hrtime() - start_time) / 1e6
    vim.notify(string.format('Finished in %.2f ms', elapsed))
  else
    vim.notify('No valid runner configuration for ' .. ft, vim.log.levels.ERROR)
  end
end

-- Execute build and run commands
function M._execute_build_and_run(build_cmd, run_cmd_fn, dir, name, start_time)
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
      zindex = 50,
    })

    vim.fn.termopen(cmd, {
      on_stdout = function(_, data, _)
        if data then
          M._update_diagnostics(data)
        end
      end,
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

  -- Execute the build command
  exec_in_term(build_cmd, function(code, win)
    if code ~= 0 then
      vim.notify('Build failed (see terminal)', vim.log.levels.ERROR)
      return
    end

    vim.api.nvim_win_close(win, true) -- Close build terminal on success

    -- Execute the run command
    local run_cmd = run_cmd_fn(dir, name)
    exec_in_term(run_cmd, function()
      local elapsed = (vim.loop.hrtime() - start_time) / 1e6
      vim.notify(string.format('Finished in %.2f ms', elapsed))
    end)
  end)
end

-- Run a selected snippet of code
function M.run_snippet()
  local ft = vim.bo.filetype
  local lang = config.languages[ft]

  if not lang then
    vim.notify('No runner configured for ' .. ft, vim.log.levels.ERROR)
    return
  end

  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"

  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
  local temp_file = vim.fn.tempname()

  vim.fn.writefile(lines, temp_file)

  local cmd = lang.cmd:gsub('%%', temp_file)
  M._open_term_and_execute(cmd)
end

-- Update diagnostics from output
function M._update_diagnostics(output)
  local diagnostics = {}
  for _, line in ipairs(output) do
    local file, lnum, col, msg = line:match '([^:]+):(%d+):(%d+):%s*(.*)'
    if file and lnum and col and msg then
      table.insert(diagnostics, {
        bufnr = vim.fn.bufnr(file),
        lnum = tonumber(lnum) - 1,
        col = tonumber(col),
        message = msg,
        severity = vim.diagnostic.severity.ERROR,
        source = 'Code Runner',
      })
    end
  end

  vim.diagnostic.set(diagnostics_ns, 0, diagnostics, {})
end

-- Open floating terminal to execute the command
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
end

-- Close floating terminal manually
function M.close()
  vim.cmd 'bd!'
end

return M
