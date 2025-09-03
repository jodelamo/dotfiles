return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = true,
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
			},
		},
	},
}
