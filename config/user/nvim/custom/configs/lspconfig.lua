local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local _, lspconfig = pcall(require, "lspconfig")
-- local _, util = pcall(require, "lspconfig/util")

local servers = {
  "lua_ls",
  "pyright",
  -- "rust_analyzer"
}

local srv_conf = {}

for _, lsp in ipairs(servers) do
  srv_conf[lsp] = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

srv_conf["lua_ls"] = vim.tbl_deep_extend("force", srv_conf["lua_ls"], {
  filetypes = {"lua"},
})

srv_conf["pyright"] = vim.tbl_deep_extend("force", srv_conf["pyright"], {
  filetypes = {"python"},
})

-- srv_conf["rust_analyzer"] = vim.tbl_deep_extend("force", srv_conf["rust_analyzer"], {
--   filetypes = {"rust"},
--   root_dir = util.root_pattern("Cargo.toml"),
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allFeatures = true,
--       }
--     }
--   },
-- })

for srv, cfg in pairs(srv_conf) do
  lspconfig[srv].setup(cfg)
end

--
-- lspconfig.pyright.setup { blabla}
