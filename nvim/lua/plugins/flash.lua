return {
  "folke/flash.nvim",
  opts = {
    modes = {
      search = {
        enabled = false,
      },
    },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, false },
    { "S", mode = { "n", "x", "o" }, false },
    { "r", mode = { "n", "x", "o" }, false },
    { "R", mode = { "n", "x", "o" }, false },
    {
      "s",
      mode = { "n" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
