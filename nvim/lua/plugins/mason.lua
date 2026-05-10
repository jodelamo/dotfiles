require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = {
		"biome",
		"html",
		"lua_ls",
		"pyright",
		"ruby_lsp",
		"stylelint_lsp",
		"terraformls",
		"ts_ls",
		"v_analyzer",
		"yamlls",
	},
})
