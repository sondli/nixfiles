 return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>pf", builtin.find_files)
      vim.keymap.set("n", "<leader>pg", builtin.live_grep)
      vim.keymap.set("n", "<leader>pb", builtin.buffers)
    end,
  },
}
