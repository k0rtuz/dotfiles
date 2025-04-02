local bt = require("awful.button")
local gears = require("gears")
local tag = require("awful.tag")

local kb = require("keyboard.global")

return gears.table.join(
  bt({}, 1, function(t)
    t:view_only()
  end),
  bt({ kb.mod }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  bt({}, 3, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
      t:view_only()
    end
  end),
  bt({}, 4, function(t)
    tag.viewnext(t.screen)
  end),
  bt({}, 5, function(t)
    tag.viewprev(t.screen)
  end)
)
