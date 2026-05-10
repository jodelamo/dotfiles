require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	live_grep = {
		additional_args = function()
			return { "--hidden", "--glob", "!**/.git/*" }
		end,
	},
	grep_string = {
		additional_args = function()
			return { "--hidden", "--glob", "!**/.git/*" }
		end,
	},
})

pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
