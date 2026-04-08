return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSInstall css diff go hcl html javascript json kdl lua markdown markdown_inline nix powershell python ruby scss terraform typescript vue v yaml",
		init = function()
			vim.filetype.add({
				extension = {
					tfvars = "terraform",
				},
			})
		end,
	},
}
