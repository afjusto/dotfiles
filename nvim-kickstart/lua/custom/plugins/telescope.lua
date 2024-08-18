return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`

    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
      defaults = {
        path_display = function(_, path)
          local tail = require('telescope.utils').path_tail(path)
          return string.format('%s (%s)', tail, path), { { { 1, #tail }, 'Constant' } }
        end,
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    local utils = require 'telescope.utils'

    -- git
    vim.keymap.set('n', '<leader>gc', function()
      builtin.git_commits {}
    end, { desc = 'Commits' })
    vim.keymap.set('n', '<leader>gs', function()
      builtin.git_status {}
    end, { desc = 'Status' })

    -- find
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fc', function()
      builtin.grep_string { search = vim.fn.input 'Grep > ' }
    end)
    vim.keymap.set('n', '<leader>fd', function()
      builtin.find_files { cwd = utils.buffer_dir() }
    end, { desc = 'Find files in current directory' })
    vim.keymap.set(
      'n',
      '<leader>ff',
      "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
      { desc = 'Find files' }
    )
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find git files' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help tags' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume previous search' })
    vim.keymap.set('n', '<leader>.', builtin.oldfiles, { desc = 'Find recent files' })
    vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Find string' })
    vim.keymap.set('n', '<leader>fw', function()
      builtin.grep_string { word_match = '-w' }
    end, { desc = 'Find word' })
    vim.keymap.set('v', '<leader>fw', function()
      builtin.grep_string {}
    end, { desc = 'Find word' })

    -- vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
    --   require('telescope').extensions.refactoring.refactors()
    -- end)
    -- vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
    --   require('refactoring').select_refactor()
    -- end)

    -- misc
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find {
        layout_strategy = 'vertical',
        previewer = true,
      }
    end, { desc = 'Search in current buffer' })
    vim.keymap.set('n', '<leader>:', builtin.command_history, { desc = 'Command History' })

    -- diagnostics
    vim.keymap.set('n', '<leader>db', builtin.diagnostics, { desc = 'Buffer diagnostics' })
  end,
}
