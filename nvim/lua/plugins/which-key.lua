return {
	urls = { "https://github.com/folke/which-key.nvim" },
	config = function()
		require("which-key").setup()

		vim.keymap.set("n", "<leader>?", function()
			require("which-key").show({ global = false })
		end, { desc = "Buffer Local Keymaps (which-key)" })
	end,
}
