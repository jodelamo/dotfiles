-- change <leader> key to comma
vim.g.mapleader = ","

-- less time for `CursorHold` (etc) to trigger
vim.o.updatetime = 250

-- colorscheme
vim.opt.termguicolors = true -- true color support
vim.opt.background = "dark"

-- make copy operations work with the clipboard
vim.opt.clipboard = "unnamedplus"

-- indentation
vim.opt.cindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true -- always indent/outdent to the nearest tabstop
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.wrap = false

-- auto-reload files changed on disk
vim.opt.autoread = true

-- disable swap files
vim.opt.updatecount = 0
vim.opt.backup = false
vim.opt.swapfile = false

-- persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- guides
vim.opt.number = true
vim.opt.colorcolumn = "80"

-- search
vim.opt.gdefault = true -- have :s///g flag on by default

-- substitution
vim.opt.inccommand = "nosplit" -- preview effects of substitution
vim.opt.ignorecase = true
vim.opt.smartcase = true
