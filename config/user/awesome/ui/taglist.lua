local awful = require("awful")
local gears = require("gears")

local kb = require("input.keyboard")

local M = {}

local buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ kb.keys.mod }, 1, function(t)
		if awful.client.focus then
			awful.client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ kb.keys.mod }, 3, function(t)
		if awful.client.focus then
			awful.client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

function M.bind(screen)
	screen.tag_list = awful.widget.taglist({
		screen = screen,
		filter = awful.widget.taglist.filter.all,
		buttons = buttons,
	})
end

return M
