return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
      },
    },
    "nvim-neotest/nvim-nio",
  },

  config = function()
    local mason_dap = require("mason-nvim-dap")
    local dap = require("dap")
    local ui = require("dapui")

    mason_dap.setup({
      ensure_installed = {
        "python",
        "codelldb",
      },
      handlers = {
        function(cfg)
          mason_dap.default_setup(cfg)
        end,

        codelldb = function(cfg)
          cfg.adapters = {
            type = "server",
            host = "127.0.0.1",
            port = "${port}",
            executable = {
              command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
              args = { "--port", "${port}" },
            },
          }
          cfg.configurations.rust = {
            name = "Launch",
            type = "lldb",
            request = "launch",
            program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
          }
          mason_dap.default_setup(cfg)
        end,
      },
    })

    ui.setup()

    -- vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end

    local keymap = vim.keymap

    keymap.set("n", "<F5>", "<cmd>DapContinue<CR>", { desc = "Continue" })
    keymap.set("n", "<F7>", "<cmd>DapStepInto<CR>", { desc = "Step into" })
    keymap.set("n", "<F8>", "<cmd>DapStepOver<CR>", { desc = "Step over" })
    keymap.set("n", "<F9>", "<cmd>DapTerminate<CR>", { desc = "Terminate" })
    keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint on current line" })
  end,
}
