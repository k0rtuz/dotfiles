-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"
local mappings = require "custom.mappings"

---@type ChadrcConfig
local M = {
  mappings = mappings,
  plugins = "custom.plugins",
}

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "onenord" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

return M
