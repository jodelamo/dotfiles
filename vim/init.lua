require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("RishabhRD/nvim-lsputils")
	use("RishabhRD/popfix")
	use("folke/tokyonight.nvim") -- color scheme
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
	use("jose-elias-alvarez/null-ls.nvim")
	use("jremmen/vim-ripgrep")
	use("kylechui/nvim-surround")
	use("lewis6991/gitsigns.nvim")
	use("neovim/nvim-lspconfig")
	use("posva/vim-vue")
	use("ray-x/go.nvim")
	use("ray-x/guihua.lua")
	use("mfussenegger/nvim-dap")
	use("theHamsta/nvim-dap-virtual-text")
	use("tpope/vim-fugitive")
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- file icons
		},
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
end)

-- Helpers
-- ============================================================================

-- convenience shortcut for keyboard mappings
local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true, silent = true }

-- Plugins
-- ============================================================================

-- nvim-tree
-------------------------------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
	},
	renderer = {
		group_empty = true,
	},
})

map("n", "<C-n>", ":NvimTreeToggle<CR>", mapOpts)

-- nvim-lspconfig
-------------------------------------------------------------------------------

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

require("lspconfig").sumneko_lua.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- null-ls.nvim
-------------------------------------------------------------------------------
local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.diagnostics.rubocop, -- ruby
	null_ls.builtins.diagnostics.shellcheck,
	null_ls.builtins.diagnostics.yamllint, -- yaml
	null_ls.builtins.formatting.beautysh, -- sh, zsh, ...
	null_ls.builtins.formatting.goimports, -- go
	null_ls.builtins.formatting.prettier,
	null_ls.builtins.formatting.rubocop,
	null_ls.builtins.formatting.shfmt,
	null_ls.builtins.formatting.stylelint,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.terraform_fmt,
	null_ls.builtins.formatting.uncrustify, -- c, c++
}

null_ls.setup({
	sources = sources,
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd([[
      augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
      ]])
		end
	end,
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

-- show telescope on Ctrl-P
map("n", "<C-p>", ":Telescope find_files<CR>", mapOpts)

-- gitsigns.nvim
-------------------------------------------------------------------------------
require("gitsigns").setup()

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

-- Config
-- ============================================================================

-- diagnostics display options
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})

-- colorscheme
vim.opt.termguicolors = true -- true color support
vim.opt.background = "dark"
vim.cmd("colorscheme tokyonight")

-- leave the past behind
vim.opt.compatible = false

-- make copy operations work with the clipboard
vim.opt.clipboard = "unnamed"

-- indentation
vim.opt.cindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true -- always indent/outdent to the nearest tabstop
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smarttab = true -- use tabs at the start of a line, spaces elsewhere
vim.opt.wrap = false

-- auto-reload files changed on disk
vim.opt.autoread = true

-- disable swap files
vim.opt.updatecount = 0
vim.opt.backup = false
vim.opt.swapfile = false

-- persistent undo
vim.opt.undodir = "/tmp"
vim.opt.hidden = true
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- guides
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.history = 200
vim.opt.ruler = true

-- search
vim.opt.hlsearch = true -- highlight all results
vim.opt.incsearch = true -- but do highlight as you type your search.
vim.opt.ignorecase = true -- make searches case-insensitive...
vim.opt.smartcase = true -- ... unless they contain at least one capital letter
vim.opt.gdefault = true -- have :s///g flag by default on"

-- split windows right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- substitution
vim.opt.inccommand = "nosplit" -- preview effects of substitution

-- Mappings
-- ============================================================================

-- change <leader> key to comma
vim.g.mapleader = ","

-- clear highlight on escape
map("n", "<esc>", ":noh<return><esc>", mapOpts)

-- don't lose selection when shifting left or right
map("x", "<", "<gv", mapOpts)
map("x", ">", ">gv", mapOpts)
map("x", "<", "<gv", mapOpts)
map("x", ">", ">gv", mapOpts)
