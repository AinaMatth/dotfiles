return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    local function setup(module, config)
      local ok, mod = pcall(require, "mini." .. module)
      if ok and mod and type(mod.setup) == "function" then
        mod.setup(config or {})
      else
        vim.notify(string.format("Failed to setup mini.nvim module: %s", module), vim.log.levels.WARN)
      end
    end

    -- Setup mini.pairs on VimEnter
    vim.api.nvim_create_autocmd("VimEnter", {
      pattern = "*",
      callback = function()
        setup("pairs", {
          modes = { insert = true, command = true, terminal = false },
          markdown = true,
        })
      end,
    })

    -- Setup mini.ai on VimEnter
    vim.api.nvim_create_autocmd("VimEnter", {
      pattern = "*",
      callback = function()
        setup("ai", {
          n_lines = 500,
        })
      end,
    })

    -- Setup mini.git on VimEnter
    vim.api.nvim_create_autocmd("VimEnter", {
      pattern = "*",
      callback = function()
        setup("git", {})
      end,
    })

    -- Setup mini.icons on VimEnter
    vim.api.nvim_create_autocmd("VimEnter", {
      pattern = "*",
      callback = function()
        setup("icons", {})
      end,
    })

    -- Setup mini.statusline on VimEnter
    vim.api.nvim_create_autocmd("VimEnter", {
      pattern = "*",
      callback = function()
        setup("statusline", {
          use_icons = vim.g.have_nerd_font,
        })
      end,
    })
  end,
}
