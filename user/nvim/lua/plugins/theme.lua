return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				custom_highlights = function(colors)
					return {
						-- Replace the group name with whatever :Inspect showed you
						["@lsp.type.extensionMethod.cs"] = { fg = colors.blue },
					}
				end,
			})
			vim.cmd([[colorscheme catppuccin-mocha]])
		end
	}
}
