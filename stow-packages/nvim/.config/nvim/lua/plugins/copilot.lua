return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = true,
		opts = {
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
		},
	},
}
