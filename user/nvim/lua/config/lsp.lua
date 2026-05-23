vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = { globals = { 'vim' } },
		},
	},
})

local vue_language_server_path = vim.fn.exepath('vue-language-server')
		:gsub('/bin/vue%-language%-server$', '')
		.. '/lib/language-tools/node_modules/.pnpm/node_modules/@vue/typescript-plugin'

local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

local vue_plugin = {
	name = '@vue/typescript-plugin',
	location = vue_language_server_path,
	languages = { 'vue' },
	configNamespace = 'typescript',
}
local vtsls_config = {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = tsserver_filetypes,
}

local ts_ls_config = {
	init_options = {
		plugins = {
			vue_plugin,
		},
	},
	filetypes = tsserver_filetypes,
}

vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', {})
vim.lsp.config('ts_ls', ts_ls_config)
vim.lsp.enable({ 'lua_ls', 'nil_ls', 'ts_ls', 'vue_ls' })

vim.lsp.enable("roslyn_ls")

vim.lsp.config("roslyn_ls", {
	filetypes = { "razor", "cs", "cshtml" },

	settings = {
		-- better performance
		["csharp|background_analysis"] = {
			dotnet_analyzer_diagnostics_scope = "openFiles",
			dotnet_compiler_diagnostics_scope = "openFiles",
		},
	},
})

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.filetype.add({
	extension = {
		cshtml = 'cshtml',
	},
})

vim.lsp.config('html', {
	capabilities = capabilities,
	filetypes = { 'html', 'cshtml' },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},
})
vim.lsp.enable('html')

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
			require('conform').format({ async = true, lsp_format = 'fallback' })
		end, 'Format buffer')
		map('n', '<leader>j', function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, 'Next error')
		map('n', '<leader>k', function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, 'Prev error')
	end,
})
