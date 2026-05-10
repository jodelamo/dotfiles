require("options")
require("keymaps")

-- Build hooks for plugins that need post-install/update steps
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end

    if name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    end

    if name == "mcphub.nvim" then
      vim.system({ "npm", "install", "-g", "mcp-hub@latest" }):wait()
    end

    if name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd(
        "TSInstall css diff go hcl html javascript json kdl lua markdown markdown_inline nix powershell python ruby scss terraform typescript vue v yaml"
      )
    end
  end,
})

-- Install and load plugins
vim.pack.add({
  -- Colorscheme (first so it's available immediately)
  "https://github.com/folke/tokyonight.nvim",

  -- Core dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- Telescope
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",

  -- LSP & Mason
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/zapling/mason-conform.nvim",

  -- Formatting & Linting
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/rshkarin/mason-nvim-lint",

  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

  -- AI
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/olimorris/codecompanion.nvim",
  "https://github.com/ravitemer/mcphub.nvim",

  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/echasnovski/mini.diff",

  -- UI
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/rcarriga/nvim-notify",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/folke/which-key.nvim",

  -- Navigation
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-pack/nvim-spectre",
  "https://github.com/jremmen/vim-ripgrep",

  -- Editing
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/folke/trouble.nvim",

  -- Go
  "https://github.com/ray-x/go.nvim",
  "https://github.com/ray-x/guihua.lua",
})

-- Configure plugins
require("plugins.tokyonight")
require("plugins.nvim-notify")
require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.mason")
require("plugins.conform")
require("plugins.nvim-lint")
require("plugins.copilot")
require("plugins.codecompanion")
require("plugins.mcphub")
require("plugins.treesitter")
require("plugins.gitsigns")
require("plugins.neogit")
require("plugins.mini-diff")
require("plugins.lualine")
require("plugins.indent-blankline")
require("plugins.which-key")
require("plugins.oil")
require("plugins.surround")
require("plugins.render-markdown")
require("plugins.todo-comments")
require("plugins.trouble")
require("plugins.spectre")
require("plugins.go")

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
