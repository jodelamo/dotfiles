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
						model = "claude-sonnet-4",
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
						-- Make individual tools (@server__tool) and server groups (@server) from MCP servers
						make_tools = true,
						-- Show individual tools in chat completion (when make_tools=true)
						show_server_tools_in_chat = true,
						-- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
						add_mcp_prefix_to_tool_names = false,
						-- Show tool results directly in chat buffer
						show_result_in_chat = true,
						-- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
						format_tool = nil,
						-- Convert MCP resources to #variables for prompts
						make_vars = true,
						-- Add MCP prompts as /slash commands
						make_slash_commands = true,
					},
				},
			},
		},
		init = function()
			-- Expand 'cc' into 'CodeCompanion' in the command line
			vim.cmd([[cab cc CodeCompanion]])
		end,
	},
}
