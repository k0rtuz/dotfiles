return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the functions below
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) --show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show LSP definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show LSP implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show LSP type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>bd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart LSP if necessary
      end,
    })

    -- used to enable autocompletion (assign to every LSP server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- change the diagnostic symbols in the sign column (gutter)
    local signs = {
      Error = " ", -- nf-fa-remove_sign
      Warn = " ", -- nf-fa-warning
      Hint = "󰠠 ", -- nf-md-lightning_bolt_circle
      Info = " ", -- nf-fa-circle_info
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local function hydrate(tbl)
      local obj = {}
      for key, val in pairs(tbl) do
        if key:find(".", 1, true) then
          local curr = val
          local it = vim.iter(vim.split(key, ".", { plain = true, trimempty = true })):rev()
          while it:peek() do
            curr = { [it:next()] = curr }
          end
          obj = vim.tbl_deep_extend("force", obj, curr)
        else
          obj = vim.tbl_deep_extend("force", obj, { [key] = val })
        end
      end
      return obj
    end

    local function load_json(path)
      local file = io.open(path, "r")
      local contents = {}
      if file then
        contents = vim.json.decode(file:read("*a"))
        file:close()
      end
      return contents
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        if server_name ~= "rust_analyzer" then
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          on_init = function(client)
            local config = hydrate(load_json(client.workspace_folders[1].name .. "/.luarc.json"))
            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, config)
          end,
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              runtime = { version = "LuaJIT" },
            },
          },
        })
      end,
      ["taplo"] = function()
        lspconfig["taplo"].setup({})
      end,
      ["ruff"] = function()
        lspconfig["ruff"].setup({})
      end,
      ["pyright"] = function()
        lspconfig["pyright"].setup({
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                ignore = { "*" },
              },
            },
          },
        })
      end,
      ["rust_analyzer"] = function()
        lspconfig["rust_analyzer"].setup({
          cmd = { "rust-analyzer" },
          capabilities = capabilities,
          filetypes = { "rust" },
          root_dir = lspconfig.util.root_pattern("Cargo.toml"),
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
            },
          },
        })
      end,
      ["texlab"] = function()
        lspconfig["texlab"].setup({
          cmd = { "texlab" },
          filetypes = { "tex", "cls" },
          root_dir = function(filename)
            return vim.fs.dirname(filename)
          end,
          settings = {
            texlab = {
              auxDirectory = ".",
              build = {
                args = { "-interaction=nonstopmode", "-synctex=1", "--shell-escape", "%f" },
                executable = "latexmk",
                forwardSearchAfter = false,
                onSave = false,
              },
              diagnosticsDelay = 300,
              formatterLineLength = 80,
              forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
              },
              latexFormatter = "tex-fmt",
            },
          },
        })
      end,
    })
  end,
}
