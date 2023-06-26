local awful = require("awful")
local gears = require("gears")
local root = require("root")

local main_menu = require("ui.menu")
local kb = require("input.keyboard")

local M = {}

M.bindings = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ kb.keys.mod }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ kb.keys.mod }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

function M.bind()
	root.buttons(gears.table.join(
		awful.button({}, 3, function()
			main_menu:toggle()
		end),
		awful.button({}, 4, awful.tag.viewnext),
		awful.button({}, 5, awful.tag.viewprev)
	))
end

return M
