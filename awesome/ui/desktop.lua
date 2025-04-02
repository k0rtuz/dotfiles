local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local tk_bt = require("mouse.tasklist")
local ly_bt = require("mouse.layout")
local taglist = require("ui.taglist")
local battery = require("ui.battery")

local set_wallpaper = function(scr)
  if beautiful.wallpaper then
    local wp = beautiful.wallpaper
    if type(wp) == "function" then
      wp = wp(scr)
    end
    gears.wallpaper.maximized(wp, scr, true)
  end
end

local setup = function(scr)
  set_wallpaper(scr)
  awful.tag({ "1", "2", "3", "4", "5" }, scr, awful.layout.layouts[1])
  scr.prompt_box = awful.widget.prompt()
  scr.layout_box = awful.widget.layoutbox(scr)
  scr.layout_box:buttons(ly_bt)
  scr.tag_list = taglist(scr)
  scr.task_list = awful.widget.tasklist({
    screen = scr,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tk_bt,
    style = {
      shape = gears.shape.rounded_bar,
    },
    widget_template = {
      id = "background_role",
      widget = wibox.container.background,
      {
        left = 10,
        right = 10,
        widget = wibox.container.margin,
        {
          layout = wibox.layout.fixed.horizontal,
          {
            margins = 2,
            widget = wibox.container.margin,
            {
              id = "icon_role",
              widget = wibox.widget.imagebox,
            },
          },
          {
            id = "text_role",
            widget = wibox.widget.textbox,
          },
        },
      },
    },
  })
  scr.main_bar = awful.wibar({ position = "top", screen = scr })
  scr.main_bar:setup({
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      scr.tag_list,
      scr.prompt_box,
    },
    scr.task_list,
    {
      layout = wibox.layout.fixed.horizontal,
      awful.widget.keyboardlayout(),
      battery(15),
      wibox.widget.systray(),
      wibox.widget.textclock(),
      scr.layout_box,
    },
  })
end

return {
  bind = function()
    screen.connect_signal("property::geometry", set_wallpaper)
    awful.screen.connect_for_each_screen(setup)
  end,
}
