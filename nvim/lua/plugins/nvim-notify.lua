return {
	urls = { "https://github.com/rcarriga/nvim-notify" },
	config = function()
		require("notify").setup({
			fps = 60,
			stages = "fade_in_slide_out",
			timeout = 3000,
		})
	end,
}
