return {
  'saghen/blink.cmp',
  dependencies = {
    'onsails/lspkind.nvim',
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    'jdrupal-dev/css-vars.nvim',
  },
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },
      ['<C-space>'] = { 'show' },
      ['<Tab>'] = false,
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 0, window = { border = 'rounded' } },
      menu = {
        auto_show = false,
        border = 'rounded',
        draw = {
          columns = {
            { 'kind_icon', 'label', gap = 1 },
            { 'kind' },
          },
          components = {
            kind_icon = {
              text = function(item)
                local kind = require('lspkind').symbol_map[item.kind] or ''
                return kind .. ' '
              end,
              highlight = 'CmpItemKind',
            },
            label = {
              text = function(item)
                return item.label
              end,
              highlight = 'CmpItemAbbr',
            },
            kind = {
              text = function(item)
                return item.kind
              end,
              highlight = 'CmpItemKind',
            },
          },
        },
      },
      ghost_text = { enabled = false, show_with_menu = false },
    },
    signature = { enabled = true, window = { border = 'rounded' } },

    sources = {
      default = { 'lsp', 'path', 'css_vars', 'snippets', 'buffer' },

      providers = {
        css_vars = {
          name = 'css-vars',
          module = 'css-vars.blink',
        },
        lsp = {
          min_keyword_length = 0,
        },
        path = {
          min_keyword_length = 0,
        },
        buffer = {
          min_keyword_length = 0,
        },
        snippets = {
          min_keyword_length = 2,
        },
      },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
