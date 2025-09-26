-- Don't lose selection when shifting left or right
vim.keymap.set({ "x", "v" }, "<", "<gv", { silent = true, desc = "Shift left and reselect" })
vim.keymap.set({ "x", "v" }, ">", ">gv", { silent = true, desc = "Shift right and reselect" })
