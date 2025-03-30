return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      " 888b    888                            d8b               ",
      " 8888b   888                            Y8P               ",
      " 88888b  888                                              ",
      " 888Y88b 888  .d88b.   .d88b.  888  888 888 88888b.d88b.  ",
      ' 888 Y88b888 d8P  Y8b d88""88b 888  888 888 888 "888 "88b ',
      " 888  Y88888 88888888 888  888 Y88  88P 888 888  888  888 ",
      " 888   Y8888 Y8b.     Y88..88P  Y8bd8P  888 888  888  888 ",
      ' 888    Y888  "Y8888   "Y88P"    Y88P   888 888  888  888 ',
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
      dashboard.button("SPC ee", "󱏒 > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC fs", "󱎸 > Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
      dashboard.button("q", "󰩈 > Quit NVIM", "<cmd>qa<CR>"),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
