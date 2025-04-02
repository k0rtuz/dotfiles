local awful = require("awful")
local bt = require("awful.button")
local gears = require("gears")
local wibox = require("wibox")

local bind_buttons = function(c)
  return gears.table.join(
    bt({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    bt({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )
end

return {
  setup = function(c)
    local buttons = bind_buttons(c)
    awful.titlebar(c):setup({
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        buttons = buttons,
        awful.titlebar.widget.iconwidget(c),
      },
      {
        layout = wibox.layout.flex.horizontal,
        buttons = buttons,
        {
          align = "center",
          widget = awful.titlebar.widget.titlewidget(c),
        },
      },
      {
        layout = wibox.layout.fixed.horizontal(),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.closebutton(c),
      },
    })
  end,
}
