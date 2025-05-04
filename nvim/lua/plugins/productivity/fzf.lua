return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    return {
      oldfiles = {
        include_current_session = true,
      },
      files = {
        fd_opts = '--type f --hidden --exclude node_modules --exclude .git --exclude .venv',
      },
      buffers = {
        sort_lastused = true,
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100,
        },
      },
      grep = {
        rg_glob = true,
        cmd = 'rg --line-number --column --no-heading --color=always --smart-case',
        rg_opts = '--hidden --glob "!node_modules/*" --glob "!.git/*" --glob "!.venv/*"',
        glob_flag = '--iglob',
        glob_separator = '%s%-%-',
      },
      live_grep = {
        cmd = 'rg --line-number --column --no-heading --color=always --smart-case',
        rg_opts = '--hidden --glob "!node_modules/*" --glob "!.git/*" --glob "!.venv/*"',
      },
      defaults = {
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
    }
  end,
  keys = {
    -- stylua: ignore start
      { "<leader>,", function() require "fzf-lua".buffers() end, desc = "Buffers" },
      { "<leader>f?", function() require "fzf-lua".builtin() end, desc = "FzfLua Builtins" },
      { "<leader>f:", function() require "fzf-lua".commands() end, desc = "Commands" },
      { "<leader>f0", function() require "fzf-lua".tmux_buffers() end, desc = "Tmux Buffers" },
      {"<leader>fr", function() require "fzf-lua".oldfiles() end, desc = "Oldfiles (All)" },
      {"<leader><leader>", function() require "fzf-lua".files({cwd= os.getenv("HOME")}) end, desc = "Find Files" },
      {"<leader>ff", function() require "fzf-lua".files() end, desc = "Find Files (cwd)" },
      {"<leader>fc", function() require "fzf-lua".files({cwd=vim.fn.stdpath("config")}) end, desc = "Find Config Files" },
      { "<leader>fz", function() require "fzf-lua".zoxide() end, desc = "Zoxide" },
      { "<leader>/", function() require "fzf-lua".live_grep() end, desc = "Grep" },
      { "<leader>fb", function() require "fzf-lua".lgrep_curbuf() end, desc = "Buffers Grep" },
      {"<leader>fh", function() require "fzf-lua".helptags() end, desc = "Help Pages" },
      { "<leader>st", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
      { "<leader>sT", function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
      -- Git
      {"<leader>fgg", function() require "fzf-lua".git_files() end, desc = "Find Git Files" },
      { "<leader>fgc", function() require "fzf-lua".git_commits() end, desc = "Git Commits" },
      { "leader>fgb", function() require "fzf-lua".git_branches() end, desc = "Git Branches" },
    -- stylua: ignore end
  },
}
