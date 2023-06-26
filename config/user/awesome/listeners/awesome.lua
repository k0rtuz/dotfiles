local awesome = require("awesome")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local menu = require("ui.menu")

local M = {}

function M.show_help()
	hotkeys_popup.show_help()
end

function M.show_menu()
	menu:show()
end

function M.restart()
	awesome.restart()
end

function M.quit()
	awesome.quit()
end

function M.run_lua_code()
	awful.prompt.run({
		prompt = "Run Lua code: ",
		textbox = awful.screen.focused().promptbox.widget,
		exe_callback = awful.util.eval,
		history_path = awful.util.get_cache_dir() .. "/history_eval",
	})
end

return M
