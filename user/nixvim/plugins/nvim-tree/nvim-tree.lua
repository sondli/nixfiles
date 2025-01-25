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
	},
	-- on_attach = function(bufnr)
	-- 	local api = require('nvim-tree.api')
	--
	-- 	local function opts(desc)
	-- 		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	-- 	end
	--
	-- 	vim.keymap.set('n', 'a', function()
	-- 		local node = api.tree.get_node_under_cursor()
	-- 		local path = node.type == "directory" and node.absolute_path or vim.fs.dirname(node.absolute_path)
	-- 		require("easy-dotnet").create_new_item(path)
	-- 	end, opts('Create file from dotnet template'))
	-- end
})
