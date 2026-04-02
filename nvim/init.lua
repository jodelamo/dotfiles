-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Configure how diagnostics are displayed in Neovim
vim.diagnostic.config({
	virtual_text = false,
	float = {
		source = true,
		border = "rounded",
	},
})

-- Show diagnostics in a floating window when the cursor is idle
vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

-- Automatically check if the file has changed on disk when Neovim regains focus
vim.api.nvim_create_autocmd("FocusGained", {
	desc = "Update file when there are changes",
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	callback = function()
		vim.cmd("checktime")
	end,
})

-- Native LSP completion
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("native_lsp_completion", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

require("options")
require("keymaps")
require("lazy").setup("plugins")
