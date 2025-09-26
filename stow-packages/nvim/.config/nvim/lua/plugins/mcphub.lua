return {
	{
		"ravitemer/mcphub.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		build = "npm install -g mcp-hub@latest",
		opts = {
			global_env = {
				ALLOWED_DIRECTORY = vim.fn.getcwd(),
			},
		},
	},
}
