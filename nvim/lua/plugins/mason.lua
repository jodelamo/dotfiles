return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = true,
      ensure_installed = {
        "biome",
        "html",
        "lua_ls",
        "pyright",
        "ruby_lsp",
        "stylelint_lsp",
        "terraformls",
        "ts_ls",
        "v_analyzer",
        "yamlls",
      },
    },
  },

  {
    -- Auto-install conform formatters
    "zapling/mason-conform.nvim",
  },
}
