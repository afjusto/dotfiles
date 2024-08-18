return {
  'nvimtools/none-ls.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'jay-babu/mason-null-ls.nvim',
    'jose-elias-alvarez/typescript.nvim',
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local mason_null_ls = require 'mason-null-ls'
    local null_ls = require 'null-ls'

    mason_null_ls.setup {
      ensure_installed = {
        'eslint_d', -- js linter
      },
    }

    null_ls.setup {
      sources = {
        require 'none-ls.code_actions.eslint_d',
        require 'none-ls.diagnostics.eslint_d',
        require 'typescript.extensions.null-ls.code-actions',
      },
    }
  end,
}
