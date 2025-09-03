return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"html",
					"pyright",
					"yamlls",
					"lua_ls",
					"ruby_lsp",
					"terraformls",
					"v_analyzer",
				},
			})

			require("lspconfig").html.setup({})
			require("lspconfig").pyright.setup({})
			require("lspconfig").yamlls.setup({
				settings = {
					yaml = {
						format = { enable = true },
						validate = { enable = true },
						hover = { enable = true },
						completion = { enable = true },
					},
				},
			})
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			require("lspconfig").ruby_lsp.setup({})
			require("lspconfig").terraformls.setup({})
			require("lspconfig").v_analyzer.setup({})

			vim.o.updatetime = 250
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false })
				end,
			})
		end,
	},

	{
		-- Auto-install conform formatters
		"zapling/mason-conform.nvim",
	},
}
