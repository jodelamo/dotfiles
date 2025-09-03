return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"giuxtaposition/blink-cmp-copilot",
		},
		version = "1.*",
		opts = {
			keymap = {
				preset = "default",
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"copilot",
				},
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			completion = {
				documentation = {
					auto_show = true,
					treesitter_highlighting = true,
					window = {
						border = "rounded",
					},
				},
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", gap = 1, "kind" },
						},
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
			appearance = {
				nerd_font_variant = "mono",
			},
		},
		opts_extend = {
			"sources.default",
		},
	},
}
