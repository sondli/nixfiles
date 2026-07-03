vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.cs",
	callback = function()
		local classname = vim.fn.expand("%:t:r") -- filename without extension

		-- Try to infer namespace from the path relative to a .csproj
		local dir = vim.fn.expand("%:p:h")
		local namespace = classname -- fallback
		local root = dir

		-- Walk up to find the nearest .csproj
		local current = dir
		while current ~= "/" do
			local csproj = vim.fn.glob(current .. "/*.csproj")
			if csproj ~= "" then
				root = current
				break
			end
			current = vim.fn.fnamemodify(current, ":h")
		end

		-- Build namespace from the relative path
		local rel = dir:sub(#root + 2) -- strip root + separator
		if rel and rel ~= "" then
			namespace = vim.fn.fnamemodify(root, ":t") .. "." .. rel:gsub("/", "."):gsub("\\", ".")
		else
			namespace = vim.fn.fnamemodify(root, ":t")
		end

		local lines = {
			"namespace " .. namespace .. ";",
			"",
			"public sealed class " .. classname,
			"{",
			"    ",
			"}",
		}

		vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
		-- Place cursor on the blank line inside the class body
		vim.api.nvim_win_set_cursor(0, { 5, 4 })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'typescript', 'typescriptreact' },
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'cs',
	callback = function()
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
	end,
})
