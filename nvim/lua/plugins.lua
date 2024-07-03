require("lazy").setup({
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = {
			contrast = "hard",
		},
	},

	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				library = {
					plugins = { "nvim-dap-ui" },
					types = true,
				},
			})
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		opts = {
			sort_by = "case_sensitive",
			view = {
				adaptive_size = true,
				width = 50,
				float = {
					enable = true,
				},
			},
			renderer = {
				group_empty = true,
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			-- list of languages
			ensure_installed = {
				"css",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"python",
				"ruby",
				"scss",
				"typescript",
				"vue",
				"yaml",
			},
			-- automatically install missing parsers when entering buffer
			auto_install = true,
			-- install languages synchronously (only applied to `ensure_installed`)
			sync_install = false,
		},
	},

	{
		"theHamsta/nvim-dap-virtual-text",
	},

	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("spectre").setup({ is_block_ui_break = true })
		end,
	},

	{
		"mfussenegger/nvim-lint",
		config = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	{},

	{
		"williamboman/mason.nvim",
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"cssls",
					"eslint",
					"html",
					"jsonls",
					"tsserver",
					"pyright",
				},
			})
		end,
	},

	{
		"hashicorp/terraform-ls",
	},

	{
		"hashivim/vim-terraform",
	},

	{
		"hrsh7th/cmp-buffer",
	},

	{
		"hrsh7th/cmp-cmdline",
	},

	{
		"hrsh7th/cmp-nvim-lsp",
	},

	{
		"hrsh7th/cmp-path",
	},

	{
		"hrsh7th/nvim-cmp",
		init = function()
			vim.opt.completeopt = { "menu", "menuone", "noselect" }
		end,
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	{
		"jghauser/mkdir.nvim",
	},

	{
		"jremmen/vim-ripgrep",
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
	},

	{
		"lukas-reineke/indent-blankline.nvim",
	},

	{
		"github/copilot.vim",
		init = function()
			vim.g.copilot_assume_mapped = true
		end,
	},

	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
		},
		config = function()
			require("go").setup()

			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimport()
				end,
				group = format_sync_grp,
			})
		end,
		event = {
			"CmdlineEnter",
		},
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				go = { "goimports" },
				javascript = { "prettierd" },
				lua = { "stylua" },
				python = { "isort", "black" },
				ruby = { "rubocop" },
				terraform = { "terraform_fmt" },
				typescript = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
	},

	{
		"tpope/vim-fugitive",
	},
})
