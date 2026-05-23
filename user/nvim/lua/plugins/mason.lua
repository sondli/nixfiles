return {
	{
		"williamboman/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
			ensure_installed = {
				-- "lua-language-server",
				-- "xmlformatter",
				-- "stylua",
				-- "bicep-lsp",
				-- "html-lsp",
				-- "css-lsp",
				-- "eslint-lsp",
				-- "typescript-language-server",
				-- "csharpier",
				-- "prettier",
				-- "json-lsp",
				-- "yaml-language-server",
				-- "markdown-oxide",

				-- for some reason those have to be installed explicitely with MasonInstall
				-- quick fix for breaking change from 18-may-26
				-- "roslyn@5.8.0-1.26266.2",  -- don't forget to do :MasonUninstall roslyn, then :MasonInstall roslyn@5.8.0-1.26266.2
				-- "netcoredbg"
			},
		},
	},
}
