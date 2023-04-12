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
vim.cmd("colorscheme gruvbox")

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
