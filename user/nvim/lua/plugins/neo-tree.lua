return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false,
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			require("neo-tree").setup({
				-- ... your other config ...
				event_handlers = {
					{
						event = "file_added",
						handler = function(filepath)
							if not filepath:match("%.cs$") then
								return
							end

							local classname = vim.fn.fnamemodify(filepath, ":t:r")
							local dir = vim.fn.fnamemodify(filepath, ":h")
							local root = dir

							local current = dir
							while current ~= "/" do
								local csproj = vim.fn.glob(current .. "/*.csproj")
								if csproj ~= "" then
									root = current
									break
								end
								current = vim.fn.fnamemodify(current, ":h")
							end

							local namespace
							local rel = dir:sub(#root + 2)
							if rel and rel ~= "" then
								namespace = vim.fn.fnamemodify(root, ":t") .. "." .. rel:gsub("/", "."):gsub("\\", ".")
							else
								namespace = vim.fn.fnamemodify(root, ":t")
							end

							local lines = {
								"namespace " .. namespace .. ";",
								"",
								"public class " .. classname,
								"{",
								"    ",
								"}",
							}

							vim.fn.writefile(lines, filepath)
						end,
					},
				},
			})
			vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
		end
	}
}
