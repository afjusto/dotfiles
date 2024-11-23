-- [[ Options ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

vim.opt.expandtab = true
vim.opt.autoindent = true

-- line wrapping
vim.opt.wrap = false

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.backspace = 'indent,eol,start'

vim.opt.breakindent = true
vim.opt.smartindent = true

-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeout = true
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

-- [[ Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'Q', '<nop>', { silent = true })

vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'Go to end of line' })
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Go to end of line' })

vim.keymap.set('n', '<leader><leader>', function()
  local utils = require 'custom.utils'
  utils.swap_last_buffer()
end, { noremap = true, silent = true, desc = 'Swap between buffers' })

-- split management
vim.keymap.set('n', '<leader>ws', '<C-w>v', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>wh', '<C-w>s', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Make split windows equally' })
vim.keymap.set('n', '<leader>wq', ':close<CR>', { desc = 'Close split window' })
vim.keymap.set('n', '<leader>wr', function()
  local utils = require 'custom.utils'
  utils.reopen_last_closed_window()
end, { noremap = true, silent = true, desc = 'Restore last closed window' })

-- buffer management
vim.keymap.set('n', '[b', ':bprev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>s', ':w<CR>', { desc = 'Save buffer' })
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- quickfix
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- commenting
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- tree explorer
vim.keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFile<CR>', { desc = 'Toggle file explorer on current file' })
vim.keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' })
vim.keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' })

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

vim.keymap.set('n', '<leader>dl', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center next search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center previous search result' })
vim.keymap.set({ 'v' }, '<leader>D', [["_d]], { desc = 'Delete to black hole register' })
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word under cursor' })

vim.keymap.set('n', '<leader>o', 'o<ESC>', { desc = 'Insert new line below' })
vim.keymap.set('n', '<leader>O', 'O<ESC>', { desc = 'Insert new line above' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', 'yp', "<cmd>let @+ = expand('%:~:.')<cr>", { desc = 'Copy relative path' })
vim.keymap.set('n', 'yP', "<cmd>let @+ = expand('%:p')<cr>", { desc = 'Copy absolute path' })

-- [[ Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('kickstart-last-loc', { clear = true }),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

--save the last closed window info
vim.api.nvim_create_autocmd('WinClosed', {
  callback = function()
    local utils = require 'custom.utils'
    utils.save_last_closed_window()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('kickstart-close-with-q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'grug-far',
    'help',
    'lspinfo',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'checkhealth',
    'neotest-output',
    'neotest-summary',
    'neotest-output-panel',
    'dbout',
    'gitsigns.blame',
    'oil',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buffer = event.buf,
      silent = true,
      desc = 'Quit buffer',
    })
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function()
    vim.cmd 'NoMatchParen'
  end,
})

-- Re-enable matchparen when leaving the buffer
vim.api.nvim_create_autocmd('BufLeave', {
  callback = function()
    vim.cmd 'DoMatchParen'
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'christoomey/vim-tmux-navigator',

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-storm'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        columns = { 'icon' },
      }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
      vim.keymap.set('n', '<space>-', require('oil').toggle_float, { desc = 'Open parent directory in floating window' })
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').add {
        { '<leader>c', group = 'Code' },
        { '<leader>d', group = 'Diagnostics' },
        { '<leader>e', group = 'File explorer' },
        { '<leader>f', group = 'Find' },
        { '<leader>g', group = 'Git' },
        { '<leader>h', group = 'Harpoon' },
        { '<leader>r', group = 'Rename' },
        { '<leader>t', group = 'Testing' },
        { '<leader>u', group = 'UI' },
        { '<leader>w', group = 'Windows' },
        {
          '<leader>?',
          function()
            require('which-key').show { global = false }
          end,
          desc = 'Buffer Keymaps (which-key)',
        },
        { '<BS>', desc = 'Decrement Selection', mode = 'x' },
        { '<C-space>', desc = 'Increment Selection', mode = { 'x', 'n' } },
      }
    end,
  },

  {
    'petertriho/nvim-scrollbar',
    event = 'BufReadPre',
    config = function()
      local colors = require('tokyonight.colors').setup()

      require('scrollbar').setup {
        handle = {
          color = colors.bg_highlight,
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      }
    end,
  },

  {
    'szw/vim-maximizer',
    keys = {
      { '<leader>wm', '<cmd>MaximizerToggle<CR>', desc = 'Maximize/minimize a window' },
    },
  },

  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    config = function()
      require('gitblame').setup { enabled = false }
      vim.keymap.set('n', '<Leader>go', ':GitBlameOpenCommitURL<CR>', { noremap = true, silent = true, desc = 'Open commit URL' })
    end,
  },

  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        transparent = true,
      }
    end,
  },

  {
    'folke/trouble.nvim',
    opts = {},
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon.setup {}

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'Add current file to Harpoon' })
      vim.keymap.set('n', '<leader>hl', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Open Harpoon list' })

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Select Harpoon list 1' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Select Harpoon list 2' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Select Harpoon list 3' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Select Harpoon list 4' })
    end,
  },

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },

  {
    'utilyre/sentiment.nvim',
    version = '*',
    event = 'VeryLazy', -- keep for lazy loading
    opts = {
      -- config
    },
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
  },

  { -- Collection of varijjous small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      local utils = require 'custom.utils'
      require('mini.ai').setup { n_lines = 500, custom_textobjects = {
        i = utils.ai_indent,
      } }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.gitsigns',
  -- require 'kickstart.plugins.debug',

  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
