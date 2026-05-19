-- Plugin loader: requires each plugin spec in order,
-- collects URLs, calls vim.pack.add(), then runs configs.

local specs = {
	"plugins.tokyonight",
	"plugins.plenary",
	"plugins.nvim-web-devicons",
	"plugins.telescope",
	"plugins.mason",
	"plugins.conform",
	"plugins.nvim-lint",
	"plugins.copilot",
	"plugins.codecompanion",
	"plugins.mcphub",
	"plugins.treesitter",
	"plugins.gitsigns",
	"plugins.neogit",
	"plugins.diffview",
	"plugins.mini-diff",
	"plugins.lualine",
	"plugins.nvim-notify",
	"plugins.indent-blankline",
	"plugins.which-key",
	"plugins.nvim-tree",
	"plugins.oil",
	"plugins.surround",
	"plugins.render-markdown",
	"plugins.todo-comments",
	"plugins.trouble",
	"plugins.spectre",
	"plugins.ripgrep",
	"plugins.go",
	"plugins.guihua",
}

local urls = {}
local configs = {}
local builds = {}

for _, mod in ipairs(specs) do
	local spec = require(mod)
	for _, url in ipairs(spec.urls or {}) do
		urls[#urls + 1] = url
		if spec.build then
			local name = type(url) == "table" and url.src or url
			builds[name:match("([^/]+)$")] = spec.build
		end
	end
	if spec.config then
		configs[#configs + 1] = spec.config
	end
end

-- Build hooks dispatched to individual plugin specs
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end
		local fn = builds[ev.data.spec.name]
		if fn then
			fn(ev)
		end
	end,
})

vim.pack.add(urls)

for _, config in ipairs(configs) do
	config()
end
