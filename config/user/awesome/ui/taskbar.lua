local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local menu = require("ui.menu")
local battery = require("widgets.battery")
local calendar = require("widgets.calendar")

local M = {}

local function setup(screen)
	screen.top_bar:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			awful.widget.launcher({ image = beautiful.awesome_icon, menu = menu }),
			screen.tag_list,
			awful.widget.prompt(),
		},
		screen.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			awful.widget.keyboardlayout(),
      battery(),
			wibox.widget.systray(),
			wibox.widget.textclock(),
			screen.layout_box,
		},
	})
end

function M.bind(screen)
	screen.top_bar = awful.wibar({
		position = "top",
		screen = screen,
	})
	setup(screen)
end

return M
