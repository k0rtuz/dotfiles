return {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    local dap = require("dap-python")
    dap.setup("uv")
    dap.test_runner = "pytest"

    local keymap = vim.keymap
    keymap.set("n", "<leader>dm", function()
      dap.test_method()
    end, { desc = "Test method" })
  end,
}
