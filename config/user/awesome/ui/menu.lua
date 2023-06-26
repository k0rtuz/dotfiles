local awesome = require("awesome")
local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local apps = require("apps")

local awesome_menu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", apps.terminal .. " -e man awesome" },
	{ "edit config", apps.editor .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

local M = awful.menu({
	items = {
		{ "awesome", awesome_menu, beautiful.awesome_icon },
		{ "open terminal", apps.terminal },
	},
})

return M
