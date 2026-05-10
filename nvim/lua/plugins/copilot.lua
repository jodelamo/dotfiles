require("copilot").setup({
	panel = {
		enabled = false,
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		hide_during_completion = true,
		keymap = {
			accept = "<Tab>",
		},
	},
	filetypes = {
		yaml = true,
		markdown = true,
		help = true,
		gitcommit = true,
		gitrebase = true,
		["."] = true,
	},
})
