return {
    'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		event = 'VeryLazy',
    dependencies = {
				{ 'nvim-lua/plenary.nvim' },
				{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
				{ 'nvim-telescope/telescope-ui-select.nvim' },
				{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
		},
		config = function()
			require('telescope').setup({
					pickers = {
						find_files = {
							theme = 'dropdown',
						}
					},
					extensions = {
						fzf = {},
						 ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
					}
			})
			require('telescope').load_extension('fzf')
			require('telescope').load_extension('ui-select')
			local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = 'Telescope Search Select' })
vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
		end,

}
