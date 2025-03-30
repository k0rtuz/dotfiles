return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local tgt = require("toggleterm")
    tgt.setup({
      size = 20,
      open_mapping = [[<c-\]],
      hide_numbers = true,
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>zo", "<cmd>ToggleTerm<CR>", { desc = "Open terminal" })
  end,
}
