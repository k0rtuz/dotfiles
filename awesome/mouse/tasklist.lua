local awful = require("awful")
local bt = require("awful.button")
local gears = require("gears")

return gears.table.join(
  bt({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  bt({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  bt({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  bt({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)
