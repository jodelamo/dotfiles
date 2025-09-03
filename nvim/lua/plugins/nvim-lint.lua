return {
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				"biomejs",
				"rubocop",
				"shellcheck",
				"stylua",
			},
		},
		event = {
			"BufWritePost",
		},
		config = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	{
		-- Auto-install nvim-lint linters
		"rshkarin/mason-nvim-lint",
	},
}
