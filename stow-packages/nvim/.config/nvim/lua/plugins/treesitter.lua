return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"css",
				"diff",
				"go",
				"hcl", -- tfvars
				"html",
				"javascript",
				"json",
				"kdl", -- zellij
				"lua",
				"markdown",
				"markdown_inline",
				"nix",
				"powershell",
				"python",
				"ruby",
				"scss",
				"terraform",
				"typescript",
				"vue",
				"v",
				"yaml",
			},
			auto_install = true,
			sync_install = false,
			highlight = {
				enable = true,
			},
		},
		init = function()
			vim.filetype.add({
				extension = {
					tfvars = "terraform",
				},
			})
		end,
	},
}
