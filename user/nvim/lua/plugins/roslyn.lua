return {
	{
		"seblyng/roslyn.nvim",
		config = function()
			require("roslyn").setup({
				extensions = {
					razor = { enabled = false }
				}
			})

			vim.lsp.config("roslyn", {

			})
		end
	}
}
