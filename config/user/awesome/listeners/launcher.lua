local awful = require("awful")
local menubar = require("menubar")

local apps = require("apps")

local M = {}

function M.spawn_terminal()
  awful.spawn(apps.terminal)
end

function M.run_prompt()
  awful.screen.focused().promptbox:run()
end

function M.launch_rofi()
	awful.spawn(apps.rofi_cmd)
end

function M.launch_browser()
	awful.spawn(apps.browser)
end

function M.show_menubar()
  menubar.show()
end

return M
