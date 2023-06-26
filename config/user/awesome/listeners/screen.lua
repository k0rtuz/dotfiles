local awful = require("awful")

local M = {}

function M.focus_on_next()
  awful.screen.focus_relative(1)
end

function M.focus_on_prev()
  awful.screen.focus_relative(-1)
end

return M
