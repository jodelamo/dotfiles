return {
	urls = { { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } },
	build = function(ev)
		if not ev.data.active then
			vim.cmd.packadd("nvim-treesitter")
		end
		vim.cmd(
			"TSInstall css diff go hcl html javascript json kdl lua markdown markdown_inline python ruby scss terraform typescript yaml"
		)
	end,
	config = function()
		vim.filetype.add({
			extension = {
				tfvars = "terraform",
			},
		})
	end,
}
