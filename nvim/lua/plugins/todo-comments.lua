return {
	urls = { "https://github.com/folke/todo-comments.nvim" },
	config = function()
		require("todo-comments").setup({
			signs = true,
		})
	end,
}
