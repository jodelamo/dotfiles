return {
	urls = { "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	config = function()
		require("render-markdown").setup({
			file_types = { "markdown", "codecompanion" },
		})
	end,
}
