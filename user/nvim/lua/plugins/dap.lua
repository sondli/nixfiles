return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio"
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Adapter
			local netcoredbg_adapter = {
				type = "executable",
				command = vim.fn.exepath("netcoredbg") ~= ""
						and vim.fn.exepath("netcoredbg")
						or "netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.adapters.netcoredbg = netcoredbg_adapter -- needed for unit test debugging
			dap.adapters.coreclr = netcoredbg_adapter -- needed for normal debugging
			-- Configuration
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Attach",
					request = "attach",
					processId = function()
						local cwd = vim.fn.getcwd()
						local csprojs = vim.fn.globpath(cwd, "**/*.csproj", false, true)

						local names = {}
						for _, path in ipairs(csprojs) do
							table.insert(names, vim.fn.fnamemodify(path, ":t:r"))
						end

						if #names == 0 then
							return require("dap.utils").pick_process()
						end

						-- Let user pick which project to attach to
						local choice = nil
						if #names == 1 then
							choice = names[1]
						else
							vim.ui.select(names, { prompt = "Select project:" }, function(selected)
								choice = selected
							end)
						end

						if not choice then
							return require("dap.utils").pick_process()
						end

						-- Try filtering by project name first, fall back to "dotnet"
						local utils = require("dap.utils")
						local procs = utils.pick_process({ filter = choice })
						return procs
					end,
				},
				{
					type = "coreclr",
					name = "Launch",
					request = "launch",
					program = function()
						local cwd = vim.fn.getcwd()
						-- Search recursively for dlls in any bin/Debug folder
						local dlls = vim.fn.globpath(cwd, "**/bin/Debug/**/*.dll", false, true)

						-- Filter out deps — only keep project-named dlls
						local candidates = {}
						for _, path in ipairs(dlls) do
							-- Skip ref assemblies and dependency dlls
							if not path:match("/ref/") and not path:match("/refs/") then
								local dir_name = path:match(".*/src/([^/]+)/") or ""
								local file_name = vim.fn.fnamemodify(path, ":t:r")
								if dir_name == file_name then
									table.insert(candidates, path)
								end
							end
						end

						if #candidates == 1 then
							return candidates[1]
						elseif #candidates > 1 then
							return vim.fn.input("Multiple dlls found, pick one: ", candidates[1], "file")
						end

						-- Fallback: manual input starting from src/
						return vim.fn.input("Path to dll: ", cwd .. "/src/", "file")
					end,
					cwd = function()
						-- resolve to the same dir as the dll
						local dlls = vim.fn.globpath(vim.fn.getcwd(), "**/bin/Debug/**/*.dll", false, true)
						for _, path in ipairs(dlls) do
							if path:match("Planner%.Backend%.dll$") then
								return vim.fn.fnamemodify(path, ":h")
							end
						end
						return vim.fn.getcwd()
					end,
					stopAtEntry = false,
				},
			}

			-- DAP UI
			dapui.setup({
				-- more minimal ui
				expand_lines = true,
				controls = { enabled = false }, -- no extra play/step buttons
				floating = { border = "rounded" },
				-- Set dapui window
				render = {
					max_type_length = 60,
					max_value_lines = 200,
				},
				-- Only one layout: just the "scopes" (variables) list at the bottom
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
						},
						size = 15,                -- height in lines (adjust to taste)
						position = "bottom",      -- "left", "right", "top", "bottom"
					},
				},
			})
			require("nvim-dap-virtual-text").setup()

			-- Auto open/close UI on debug sessions
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Keymaps
			vim.keymap.set("n", "<leader>dd", function()
				vim.fn.system("dotnet build")
				dap.continue()
			end, { desc = "Debug: Build and launch" })
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
			vim.keymap.set("n", "<leader>ds", dap.terminate, { desc = "Debug: Stop" })
		end,
	},
}
