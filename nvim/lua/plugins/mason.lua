return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = true,
			ensure_installed = {
				"html",
				"pyright",
				"yamlls",
				"lua_ls",
				"ruby_lsp",
				"stylelint-lsp",
				"terraformls",
				"v_analyzer",
			},
		},
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},

	{
		-- Auto-install conform formatters
		"zapling/mason-conform.nvim",
	},
}
