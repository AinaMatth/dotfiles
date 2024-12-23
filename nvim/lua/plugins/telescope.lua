return {
	'nvim-telescope/telescope.nvim',
	event = 'VeryLazy',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function() return vim.fn.executable('make') == 1 end,
			cmd = 'Telescope', -- Load only when needed
		},
		{ 'nvim-telescope/telescope-ui-select.nvim', cmd = 'Telescope' },
		{ 'nvim-tree/nvim-web-devicons',             enabled = vim.g.have_nerd_font },
	},
	config = function()
		local telescope = require('telescope')

		-- Telescope setup with minimal defaults
		telescope.setup {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
			},
			extensions = {
				['ui-select'] = require('telescope.themes').get_dropdown(),
			},
		}

		-- Load extensions
		local function load_extensions()
			local success, _ = pcall(telescope.load_extension, 'fzf')
			if not success then
				print("Failed to load fzf extension")
			end
			success, _ = pcall(telescope.load_extension, 'ui-select')
			if not success then
				print("Failed to load ui-select extension")
			end
		end

		-- Lazy load extensions
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopeStarted",
			callback = load_extensions,
		})

		-- Key mappings for Telescope functions
		local builtin = require 'telescope.builtin'
		local map = vim.keymap.set
		local desc = function(text) return { desc = text } end

		-- Basic mappings
		local mappings = {
			{ 'n', '<leader>sh',       builtin.help_tags,   '[S]earch [H]elp' },
			{ 'n', '<leader>sk',       builtin.keymaps,     '[S]earch [K]eymaps' },
			{ 'n', '<leader>sf',       builtin.find_files,  '[S]earch [F]iles' },
			{ 'n', '<leader>ss',       builtin.builtin,     '[S]earch [S]elect Telescope' },
			{ 'n', '<leader>sw',       builtin.grep_string, '[S]earch current [W]ord' },
			{ 'n', '<leader>sg',       builtin.live_grep,   '[S]earch by [G]rep' },
			{ 'n', '<leader>sd',       builtin.diagnostics, '[S]earch [D]iagnostics' },
			{ 'n', '<leader>sr',       builtin.resume,      '[S]earch [R]esume' },
			{ 'n', '<leader>s.',       builtin.oldfiles,    '[S]earch Recent Files ("." for repeat)' },
			{ 'n', '<leader><leader>', builtin.buffers,     '[ ] Find existing buffers' },
			{ 'n', '<leader>/', function()
				builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end, '[/] Fuzzily search in current buffer' },
			{ 'n', '<leader>s/', function()
				builtin.live_grep {
					grep_open_files = true,
					prompt_title = 'Live Grep in Open Files',
				}
			end, '[S]earch [/] in Open Files' },
			{ 'n', '<leader>sc', function()
				builtin.find_files { cwd = vim.fn.stdpath('config') }
			end, '[S]earch [N]eovim files' },
		}

		-- Set key mappings
		for _, mapping in ipairs(mappings) do
			map(mapping[1], mapping[2], mapping[3], desc(mapping[4]))
		end
	end,
}
