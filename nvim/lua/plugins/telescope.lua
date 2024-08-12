return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>,", false },
    { "<leader>/", false },
    { "<leader><space>", false },
    { "<leader>.", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    {
      "<leader>/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find({
          layout_strategy = "vertical",
        })
      end,
      desc = "Search in current buffer",
    },
    {
      "<leader>fd",
      function()
        require("telescope.builtin").find_files({
          cwd = require("telescope.utils").buffer_dir(),
        })
      end,
      desc = "Find files in current directory",
    },
    -- find
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
    { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>fR", false },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
    -- search
    { '<leader>s"', false },
    { "<leader>sa", false },
    { "<leader>sb", false },
    { "<leader>sc", false },
    { "<leader>sC", false },
    { "<leader>sd", false },
    { "<leader>sD", false },
    { "<leader>db", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
    { "<leader>dB", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>sg", false },
    { "<leader>sG", false },
    { "<leader>fs", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    { "<leader>fS", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sh", false },
    { "<leader>sk", false },
    { "<leader>sH", false },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
    { "<leader>sj", false },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
    { "<leader>sl", false },
    { "<leader>sM", false },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>sm", false },
    { "<leader>so", false },
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sR", false },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
    { "<leader>sq", false },
    { "<leader>sw", false },
    { "<leader>sW", false },
    { "<leader>sw", mode = "v", false },
    { "<leader>sW", mode = "v", false },
    { "<leader>fw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
    { "<leader>fW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
    { "<leader>fw", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
    { "<leader>fW", LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
    { "<leader>uC", false },
    { "<leader>ss", false },
    { "<leader>sS", false },
    {
      "<leader>fo",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = LazyVim.config.get_kind_filter(),
        })
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>fO",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
          symbols = LazyVim.config.get_kind_filter(),
        })
      end,
      desc = "Goto Symbol (Workspace)",
    },
    {
      "<leader>fc",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end,
      desc = "Grep string",
    },
  },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        path_display = function(_, path)
          local tail = require("telescope.utils").path_tail(path)
          return string.format("%s (%s)", tail, path), { { { 1, #tail }, "Constant" } }
        end,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
    }
  end,
}
