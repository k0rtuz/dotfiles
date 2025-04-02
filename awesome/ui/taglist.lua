local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local xrec = require("beautiful.xresources")
local dpi = xrec.apply_dpi

local tg_bt = require("mouse.taglist")

-- local donut = function(width, height)
-- return function(cr)
-- gears.shape.arc(cr, width, height, nil, 0, 2 * math.pi)
-- end
-- end

local tag_size = dpi(24)
local tpl = {
  id = "background_role",
  widget = wibox.container.background,
  {
    {
      id = "index_role",
      widget = wibox.widget.textbox,
      align = "center",
      valign = "center",
    },
    {
      id = "icon_role",
      image = gears.filesystem.get_themes_dir() .. "custom/taglist/empty.svg",
      resize = true,
      forced_width = tag_size,
      forced_height = tag_size,
      widget = wibox.widget.imagebox,
    },
    layout = wibox.layout.stack,
  },
  create_callback = function(self, tag, index, tags)
    self:get_children_by_id("index_role")[1].markup = "<b>" .. index .. "</b>"
  end,
}

return function(scr)
  return awful.widget.taglist({
    screen = scr,
    filter = awful.widget.taglist.filter.all,
    layout = {
      spacing = 6,
      spacing_widget = {
        color = "#dddddd",
        shape = gears.shape.rect,
        visible = false,
        widget = wibox.widget.separator,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = tpl,
    buttons = tg_bt,
  })
end
