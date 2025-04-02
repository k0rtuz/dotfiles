local awful = require("awful")
local bt = require("awful.button")
local kb = require("keyboard.base")
local gears = require("gears")

return gears.table.join(
  bt({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  bt({ kb.mod }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  bt({ kb.mod }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)
