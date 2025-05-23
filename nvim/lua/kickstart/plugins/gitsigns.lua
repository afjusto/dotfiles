-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(buffer)
        local gs = require 'gitsigns'

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- Navigation
        map('n', ']g', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gs.nav_hunk 'next'
          end
        end, 'Next Hunk')

        map('n', '[g', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gs.nav_hunk 'prev'
          end
        end, 'Prev Hunk')

        map('n', ']G', function()
          gs.nav_hunk 'last'
        end, 'Last Hunk')
        map('n', '[G', function()
          gs.nav_hunk 'first'
        end, 'First Hunk')

        -- Actions
        map({ 'n', 'v' }, '<leader>gp', gs.preview_hunk, 'Preview Hunk Inline')
        map({ 'n', 'v' }, '<leader>ga', ':Gitsigns stage_hunk<CR>', 'Stage hunk')
        map({ 'n', 'v' }, '<leader>gA', ':Gitsigns stage_buffer<CR>', 'Stage buffer')
        map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', 'Reset hunk')
        map({ 'n', 'v' }, '<leader>gR', ':Gitsigns reset_buffer<CR>', 'Reset buffer')
        map('n', '<leader>gb', function()
          gs.blame_line { full = true }
        end, 'Show blame')

        map('n', '<leader>gB', ':G blame<CR>', 'Show blame for all lines')
      end,
    },
  },
}
