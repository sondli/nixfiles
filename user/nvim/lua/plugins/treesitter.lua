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
				"html"
			}
		end
	}
}
