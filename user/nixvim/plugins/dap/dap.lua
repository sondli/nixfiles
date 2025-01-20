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


-- -- Configuration for launch mode
-- local launch_config = {
-- 	type = "coreclr",
-- 	name = "launch - netcoredbg",
-- 	request = "launch",
-- 	program = function()
-- 		if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
-- 			local project_path = vim.fn.input('Path to your *proj file: ', vim.fn.getcwd() .. '/', 'file')
-- 			local cmd = 'dotnet build -c Debug ' .. project_path
-- 			print('Building ' .. cmd)
-- 			os.execute(cmd)
-- 		end
-- 		return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
-- 	end,
-- 	cwd = '${workspaceFolder}',
-- 	env = {
-- 		ASPNETCORE_ENVIRONMENT = "Local"
-- 	},
-- 	args = { "--launch-profile", "Local" }
-- }
--
-- -- Configuration for attach mode
-- local attach_config = {
-- 	type = "coreclr",
-- 	name = "attach - netcoredbg",
-- 	request = "attach",
-- 	processId = function()
-- 		return require('dap.utils').pick_process({
-- 			filter = function(proc)
-- 				return proc.name:find("dotnet") ~= nil
-- 			end
-- 		})
-- 	end
-- }
--
-- -- Register both configurations
-- dap.configurations.cs = { launch_config, attach_config }
