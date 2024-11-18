local dap = require("dap")
dap.configurations.rust = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			local requestExe = function()
				return vim.fn.input({
					prompt = 'Path to executable: ',
					default = vim.fn.getcwd() .. '/target/debug/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t'),
					completion = 'file'
				})
			end

			if vim.g['rust_last_exe_path'] == nil then
				vim.g['rust_last_exe_path'] = requestExe()
			else
				if vim.fn.confirm('Do you want to change the path to executable?\n' .. vim.g['rust_last_exe_path'],
							'&yes\n&no', 2) == 1 then
					vim.g['rust_last_exe_path'] = requestExe()
				end
			end
			return vim.g['rust_last_exe_path']
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
		args = function()
			local requestArgs = function()
				return vim.fn.input({
					prompt = 'Args: ',
					completion = 'file'
				})
			end

			if vim.g['rust_last_args'] == nil then
				vim.g['rust_last_args'] = requestArgs()
			else
				if vim.fn.confirm('Do you want to change the arguments?\n' .. vim.g['rust_last_args'],
							'&yes\n&no', 2) == 1 then
					vim.g['rust_last_args'] = requestArgs()
				end
			end
			return vim.g['rust_last_args']
		end
	},
}
