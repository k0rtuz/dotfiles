local awful = require("awful")
local bt = require("awful.button")
local gears = require("gears")

local next = function()
  awful.layout.inc(1)
end

local prev = function()
  awful.layout.inc(-1)
end

return gears.table.join(bt({}, 1, next), bt({}, 3, prev), bt({}, 4, next), bt({}, 5, prev))
