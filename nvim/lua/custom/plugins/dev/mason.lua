return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local lsp = require("mason-lspconfig")
    local installer = require("mason-tool-installer")

    mason.setup({
      -- PATH = "append",
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    lsp.setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff",
        "rust_analyzer",
      },
    })

    installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "selene",
        "ruff",
      },
    })
  end,
}
