-- Helpers
-- ============================================================================

-- convenience shortcut for keyboard mappings
local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true, silent = true }

-- change <leader> key to comma
vim.g.mapleader = ","

-- clear highlight on escape
map("n", "<esc>", ":noh<return><esc>", mapOpts)

-- don't lose selection when shifting left or right
map("x", "<", "<gv", mapOpts)
map("x", ">", ">gv", mapOpts)
map("x", "<", "<gv", mapOpts)
map("x", ">", ">gv", mapOpts)

-- Plugin keymaps
-- ============================================================================

-- nvim-tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", mapOpts)

-- telescope.vim
map("n", "<C-p>", ":Telescope find_files hidden=true<CR>", mapOpts)

-- trouble.nvim
map("n", "<leader>xx", ":TroubleToggle<CR>", mapOpts)
