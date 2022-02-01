local paq = require("paq")

paq({
	-- package manager
	"savq/paq-nvim",

	-- color scheme
	"folke/tokyonight.nvim",

	-- lsp
	"neovim/nvim-lspconfig",
	"nvim-lua/plenary.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"RishabhRD/popfix",
	"RishabhRD/nvim-lsputils",

	-- completion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",

	-- snippets
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",

	-- search
	"mileszs/ack.vim",

	-- fuzzy search
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"ojroques/nvim-lspfuzzy",

	-- highlighting
	{ "nvim-treesitter/nvim-treesitter", run = "TSUpdate" },
	"posva/vim-vue",

	-- netrw
	"tpope/vim-vinegar",

	-- git
	"lewis6991/gitsigns.nvim",

	-- mkdir
	"jghauser/mkdir.nvim",
})

-- Helpers
-- ============================================================================

-- convenience shortcut for keyboard mappings
local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true, silent = true }

-- Plugins
-- ============================================================================

-- ack.vim
vim.g["ackprg"] = "ag --vimgrep"

-- nvim-lspconfig
---------------------------------------------------------------------------

-- nvim-cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- typescript
require("lspconfig").tsserver.setup({
	capabilities = capabilities,
})

-- eslint
require("lspconfig").eslint.setup({
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
---------------------------------------------------------------------------
local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.diagnostics.eslint,
	null_ls.builtins.diagnostics.shellcheck,
	null_ls.builtins.diagnostics.yamllint,
	null_ls.builtins.formatting.goimports,
	null_ls.builtins.formatting.prettier,
	null_ls.builtins.formatting.shfmt,
	null_ls.builtins.formatting.stylelint,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.terraform_fmt,
}

null_ls.setup({
	sources = sources,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
        augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
        augroup END
      ]])
		end
	end,
})

-- nvim-lsputils.nvim
---------------------------------------------------------------------------
vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler

-- nvim-lspfuzzy
---------------------------------------------------------------------------
require("lspfuzzy").setup({})

-- nvim-treesitter
---------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
	-- one of "all", "maintained", or a list of languages
	ensure_installed = "maintained",

	-- install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,
})

-- nvim-cmp
---------------------------------------------------------------------------
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
		["<C-Space>"] = cmp.mapping.complete(),
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

-- fzf.vim
---------------------------------------------------------------------------
-- Add fzf to runtime path
vim.opt.rtp:append("/usr/local/opt/fzf")

-- reverse layout to top-down
vim.env.FZF_DEFAULT_OPTS = "--reverse"

-- show fzf on Ctrl-P
map("n", "<C-p>", ":Files<CR>", mapOpts)

-- gitsigns.nvim
require("gitsigns").setup()

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
