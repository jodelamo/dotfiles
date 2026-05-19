return {
	urls = { "https://github.com/nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-web-devicons").setup({
			default = true,
			strict = true,
		})
	end,
}
