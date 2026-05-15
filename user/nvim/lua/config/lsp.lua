vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = { globals = { 'vim' } },
		},
	},
})

vim.lsp.config('ts_ls', {
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'vue' },
})

vim.lsp.config('vue_ls', {
	filetypes = { 'vue' },
})

vim.lsp.enable({ 'lua_ls', 'nil_ls', 'ts_ls', 'vue_ls' })

vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = 'rounded',
		source = 'if_many',
	},
	underline = true,
	virtual_text = {
		spacing = 2,
		source = 'if_many',
		prefix = '●',
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = 'E',
			[vim.diagnostic.severity.WARN] = 'W',
			[vim.diagnostic.severity.INFO] = 'I',
			[vim.diagnostic.severity.HINT] = 'H',
		},
	},
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local bufnr = args.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map('n', 'K', vim.lsp.buf.hover, 'LSP Hover')
		map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
		map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
		map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
		map('n', 'gr', vim.lsp.buf.references, 'References')
		map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
		map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
		map('n', '<leader>f', function()
			vim.lsp.buf.format({ async = true })
		end, 'Format buffer')
		map('n', '<leader>j', function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, 'Next error')
		map('n', '<leader>k', function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, 'Prev error')
	end,
})
