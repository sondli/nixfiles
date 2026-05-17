return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nsidorenco/neotest-vstest"
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-vstest")
				}
			})


			vim.keymap.set("n", "<leader>tp", function()
				require("neotest").summary.toggle()
			end)

			vim.keymap.set("n", "<leader>ta", function()
				require("neotest").run.run({ suite = true })
			end)

			vim.keymap.set("n", "<leader>tf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end)

			vim.keymap.set("n", "<leader>tn", function()
				require("neotest").run.run()
			end)

			vim.keymap.set("n", "<leader>tdn", function()
				require("neotest").run.run({ strategy = "dap" })
			end)
		end
	}
}
