return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    opts = function(_, opts)
      opts.transparent_background = true
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
