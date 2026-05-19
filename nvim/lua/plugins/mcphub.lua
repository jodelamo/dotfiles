return {
	urls = { "https://github.com/ravitemer/mcphub.nvim" },
	build = function()
		vim.system({ "npm", "install", "-g", "mcp-hub@latest" }):wait()
	end,
	config = function()
		require("mcphub").setup({
			global_env = {
				ALLOWED_DIRECTORY = vim.fn.getcwd(),
			},
		})
	end,
}
