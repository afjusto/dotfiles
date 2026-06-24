return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'oxlint_fix', 'oxfmt' },
      typescript = { 'oxlint_fix', 'oxfmt' },
      javascriptreact = { 'oxlint_fix', 'oxfmt' },
      typescriptreact = { 'oxlint_fix', 'oxfmt' },
      css = { 'oxfmt' },
      sass = { 'oxfmt' },
      scss = { 'oxfmt' },
      html = { 'oxfmt' },
      json = { 'oxfmt' },
      yaml = { 'oxfmt' },
    },
    formatters = {
      oxfmt = {
        command = 'oxfmt',
        args = { '--stdin-filepath', '$FILENAME' },
        stdin = true,
      },
      oxlint_fix = {
        command = 'oxlint',
        args = { '--fix', '$FILENAME' },
        stdin = false,
      },
    },
  },
}
