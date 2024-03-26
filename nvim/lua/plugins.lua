require("packer").startup(function(use)
	use("RishabhRD/nvim-lsputils")
	use("RishabhRD/popfix")
	use("ellisonleao/gruvbox.nvim")
	use({
		"folke/trouble.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})
	use("hashicorp/terraform-ls")
	use("hashivim/vim-terraform")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/vim-vsnip")
	use("iamcco/markdown-preview.nvim")
	use("jghauser/mkdir.nvim")
	use("jremmen/vim-ripgrep")
	use("kylechui/nvim-surround")
	use("lewis6991/gitsigns.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use({
		"rcarriga/nvim-dap-ui",
		requires = {
			"mfussenegger/nvim-dap",
		},
	})
	use("folke/neodev.nvim")
	use("neovim/nvim-lspconfig")
	use("numToStr/Comment.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("posva/vim-vue")
	use("ray-x/go.nvim")
	use("ray-x/guihua.lua")
	use("theHamsta/nvim-dap-virtual-text")
	use("tpope/vim-fugitive")
	use("wbthomason/packer.nvim")
	use("github/copilot.vim")
	use("stevearc/conform.nvim")
end)

-- Plugins
-- ============================================================================

-- Comment.nvim
require("Comment").setup()

-- conform.nvim
require("conform").setup({
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
})

-- gruvbox.nvim
require("gruvbox").setup({
	contrast = "hard",
})

-- nvim-tree
-------------------------------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
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
})

-- neodev.nvim
-------------------------------------------------------------------------------
require("neodev").setup()

-- nvim-lspconfig
-------------------------------------------------------------------------------
-- show floating window after a short while when cursor is over diagnostic
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- nvim-cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- css
require("lspconfig").cssls.setup({
	capabilities = capabilities,
})

-- typescript
require("lspconfig").tsserver.setup({
	capabilities = capabilities,
})

-- eslint
require("lspconfig").eslint.setup({
	capabilities = capabilities,
})

-- stylelint
require("lspconfig").stylelint_lsp.setup({
	capabilities = capabilities,
})

-- vue
require("lspconfig").vuels.setup({
	capabilities = capabilities,
})

-- python
require("lspconfig").pyright.setup({
	capabilities = capabilities,
})

-- ruby
require("lspconfig").solargraph.setup({
	capabilities = capabilities,
})

-- go
require("lspconfig").gopls.setup({
	capabilities = capabilities,
})

-- html
require("lspconfig").html.setup({
	capabilities = capabilities,
})

-- yaml
require("lspconfig").yamlls.setup({
	capabilities = capabilities,
})

-- terraform
require("lspconfig").terraformls.setup({
	capabilities = capabilities,
})

-- lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- nvim-lsputils.nvim
-------------------------------------------------------------------------------
vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler

-- nvim-treesitter
-------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
	-- list of languages
	ensure_installed = {
		"c",
		"cpp",
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
})

-- nvim-dap-virtual-text
-------------------------------------------------------------------------------
require("nvim-dap-virtual-text").setup({})

-- nvim-cmp
-------------------------------------------------------------------------------
vim.opt.completeopt:append("menu")
vim.opt.completeopt:append("menuone")
vim.opt.completeopt:append("noselect")

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `vsnip` users.
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "buffer" },
	}),
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping(
			cmp.mapping.complete({
				reason = cmp.ContextReason.Auto,
			}),
			{ "i", "c" }
		),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- elseif luasnip.expand_or_jumpable() then
			-- luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			-- elseif luasnip.jumpable(-1) then
			-- luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})

-- nvim-surround
-------------------------------------------------------------------------------
require("nvim-surround").setup()

-- telescope.vim
-------------------------------------------------------------------------------
require("telescope").setup({})

-- gitsigns.nvim
-------------------------------------------------------------------------------
require("gitsigns").setup()

-- lukas-reineke/indent-blankline.nvim
-------------------------------------------------------------------------------
require("ibl").setup()

-- go.nvim
-------------------------------------------------------------------------------
require("go").setup()

-- run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimport()
	end,
	group = format_sync_grp,
})

-- trouble.nvim
-------------------------------------------------------------------------------
require("trouble").setup()

-- copilot.vim
-------------------------------------------------------------------------------
vim.g.copilot_assume_mapped = true
