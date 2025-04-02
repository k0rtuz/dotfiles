local awful = require("awful")
local bt = require("awful.button")
local gears = require("gears")

return {
  bind = function()
    root.buttons(gears.table.join(bt({}, 4, awful.tag.viewnext), bt({}, 5, awful.tag.viewprev)))
  end,
}
