local awful = require("awful")
local gears = require("gears")
local screen = require("screen")

local taglist = require("ui.taglist")
local tasklist = require("ui.tasklist")
local taskbar = require("ui.taskbar")
local wallpaper = require("ui.wallpaper")

local M = {}

local function bind(s)
	-- Wallpaper
	wallpaper.set(s)

	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.layout_box = awful.widget.layoutbox(s)
	s.layout_box:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
  taglist.bind(s)

	-- Create a tasklist widget
  tasklist.bind(s)
  taskbar.bind(s)
end

function M.init()
	-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
	screen.connect_signal("property::geometry", wallpaper.set)
	awful.screen.connect_for_each_screen(bind)
end

return M
