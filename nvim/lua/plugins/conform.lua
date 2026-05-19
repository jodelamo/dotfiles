return {
	urls = { "https://github.com/stevearc/conform.nvim" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- scss = { "stylelint" },
				go = { "goimports" },
				-- json = { "jq" },
				lua = { "stylua" },
				python = { "isort", "black" },
				terraform = { "terraform_fmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		})

		vim.keymap.set("", "<leader>f", function()
			require("conform").format({ async = true })
		end, { desc = "Format buffer" })
	end,
}
