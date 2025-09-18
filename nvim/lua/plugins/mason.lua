return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
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
		},
		config = function()
			vim.lsp.config("html", {})
			vim.lsp.config("pyright", {})
			vim.lsp.config("ruby_lsp", {})
			vim.lsp.config("terraformls", {})
			vim.lsp.config("v_analyzer", {})
			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						format = { enable = true },
						validate = { enable = true },
						hover = { enable = true },
						completion = { enable = true },
					},
				},
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

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
