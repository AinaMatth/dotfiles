-- Initialization ===========================================================
vim.loader.enable()
_G.Config = {}


-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath 'data' .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd 'packadd mini.nvim | helptags ALL'
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

-- Set up 'mini.deps'
require('mini.deps').setup { path = { package = path_package } }
-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local cmd = function(cmd)
  return function()
    vim.cmd(cmd)
  end
end

local load = function(spec, opts)
  return function()
    opts = opts or {}
    local slash = string.find(spec, '/[^/]*$') or 0
    local name = opts.init or string.sub(spec, slash + 1)
    if slash ~= 0 then
      add(vim.tbl_deep_extend('force', { source = spec }, opts.add or {}))
    end
    require(name)
    if opts.setup then
      require(name).setup(opts.setup)
    end
  end
end

-- Settings and mappings ====================================================
now(load("settings"))
now(load("autocmds"))

-- Mini.nvim ================================================================
add { name = 'mini.nvim' }


-- Now ============================================================================
now(load("rebelot/kanagawa.nvim", { add = { name = "kanagawa" }, init = "plugins.kanagawa" }))
now(cmd("colorscheme kanagawa"))

now(load("plugins.mini.basics"))
now(load("mini.icons", {setup = {}}))
now(load("plugins.mini.files"))


-- Later ==============================================================

later(load("plugins.mini.notify"))
later(load("mini.pairs", { setup = {} }))
later(load("mini.align", { setup = {} }))
later(load("mini.animate",    { setup = {} }))
later(load("mini.bracketed", { setup = {} }))
later(load("mini.bufremove", { setup = {} }))
later(load("mini.colors", { setup = {} }))
later(load("mini.comment", { setup = {} }))
later(load("mini.extra", { setup = {} }))
later(load("mini.operators", { setup = {} }))
later(load("mini.trailspace", { setup = {} }))

later(load("nvim-treesitter/nvim-treesitter", {
  init = "plugins.treesitter",
  add = { hooks = { post_checkout = cmd(":TSUpdate") } },
}))







-- Blink.cmp ==============================================================
local function build_blink(params)
  vim.notify('Building blink.cmp', vim.log.levels.INFO)
  local obj = vim.system({ 'cargo', 'build', '--release' }, { cwd = params.path }):wait()
  if obj.code == 0 then
    vim.notify('Building blink.cmp done', vim.log.levels.INFO)
  else
    vim.notify('Building blink.cmp failed', vim.log.levels.ERROR)
  end
end
later(load('saghen/blink.cmp', {
  init = "plugins.blink",
  add = {
     source = "saghen/blink.cmp",
    depends = {
      "rafamadriz/friendly-snippets",
    },
    checkout = "v1.1.1",
    hooks = {
      post_install = build_blink,
      post_checkout = build_blink,
    },
  }
}))

later(load("neovim/nvim-lspconfig", {
  init = "plugins.lspconfig",
  add = {
    depends = {
      "williamboman/mason.nvim",
      "folke/lazydev.nvim",
    },
  },
}))
