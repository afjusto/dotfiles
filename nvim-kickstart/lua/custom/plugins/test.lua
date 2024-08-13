return {
  'vim-test/vim-test',
  dependencies = {
    'preservim/vimux',
  },
  config = function()
    vim.keymap.set('n', '<leader>T', ':TestNearest<CR>')
    vim.keymap.set('n', '<leader>t', ':TestFile<CR>')
    vim.cmd "let test#strategy = 'vimux'"
    -- vim.cmd("let test#strategy = 'neovim'")
    -- vim.cmd("let test#neovim#start_normal = 1")
    vim.cmd "let test#javascript#jest#options = '--watch TZ=UTC'"
    --
    -- vim.cmd("let test#neovim#term_position = 'vert'")
    vim.cmd "let g:VimuxOrientation = 'h'"
    vim.cmd 'let g:VimuxHeight = 40'
  end,
}
