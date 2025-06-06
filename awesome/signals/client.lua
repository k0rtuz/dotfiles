local awful = require("awful")
local titlebar = require("ui.titlebar")

return {
  connect = function()
    -- Signal function to execute when a new client appears.
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    client.connect_signal("manage", function(c)
      if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
      end
    end)
    client.connect_signal("request::titlebars", titlebar.setup)
  end,
}
