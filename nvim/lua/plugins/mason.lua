return {
	urls = {
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/mason-org/mason.nvim",
		"https://github.com/williamboman/mason-lspconfig.nvim",
		"https://github.com/zapling/mason-conform.nvim",
	},
	config = function()
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
	end,
}
