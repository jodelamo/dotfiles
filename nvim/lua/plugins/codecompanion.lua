return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			strategies = {
				chat = {
					adapter = {
						name = "copilot",
						model = "claude-sonnet-4.5",
					},
					tools = {
						opts = {
							default_tools = {
								"files",
								"mcp",
							},
						},
					},
				},
				cmd = {
					adapter = "copilot",
				},
				inline = {
					adapter = "copilot",
					keymaps = {
						accept_change = {
							modes = { n = "ga" },
							description = "Accept the suggested change",
						},
						reject_change = {
							modes = { n = "gr" },
							opts = { nowait = true },
							description = "Reject the suggested change",
						},
					},
				},
			},
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						make_tools = true,
						show_server_tools_in_chat = true,
						add_mcp_prefix_to_tool_names = false,
						show_result_in_chat = true,
						format_tool = nil,
						make_vars = true,
						make_slash_commands = true,
					},
				},
			},
		},
		init = function()
			vim.cmd([[cab ccc CodeCompanionChat]])
			vim.cmd([[cab cc CodeCompanion #{buffer}]])
			vim.cmd([[cab ca CodeCompanionActions]])

			-- Set up notifications for CodeCompanion events
			local notify = require("notify")
			local notif_title = "CodeCompanion"
			local notif_id = nil

			vim.api.nvim_create_augroup("CodeCompanionNotify", { clear = true })

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanion*",
				group = "CodeCompanionNotify",
				callback = function(request)
					if request.match == "CodeCompanionRequestStarted" then
						notif_id = notify("Crunching...", "info", {
							title = notif_title,
							timeout = false,
						})
					end
					if request.match == "CodeCompanionRequestFinished" then
						notify("Done!", "info", {
							title = notif_title,
							replace = notif_id,
							timeout = 3000,
						})
					end
				end,
			})
		end,
	},
}
