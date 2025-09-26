return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
				opts = {
					default = true,
					strict = true,
				},
			},
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>")
		end,
		opts = {
			sort_by = "case_sensitive",
			view = {
				adaptive_size = true,
				width = 50,
			},
			renderer = {
				group_empty = true,
			},
		},
	},
}
