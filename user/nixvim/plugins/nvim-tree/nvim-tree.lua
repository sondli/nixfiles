-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>pv", "<Cmd>NvimTreeToggle<CR>")

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
    filters = {
        dotfiles = false
    },
    actions = {
        open_file = {
            quit_on_open = true
        }
    }

})
