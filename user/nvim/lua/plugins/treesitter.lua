return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').install {
				"lua",
				"nix",
				"javascript",
				"typescript",
				"c_sharp",
				"vue",
				"html",
				"razor",
				"css"
			}
			vim.treesitter.language.register('razor', 'cshtml')
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'cshtml',
				callback = function()
					vim.treesitter.start()
				end,
			})
		end
	}
}
