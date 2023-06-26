local awful = require("awful")
local client = require("client")
local gears = require("gears")
local root = require("root")

local lst = require("listeners")

local M = {
	keys = {
		mod = "Mod4",
		alt = "Mod1",
	},
	bindings = {},
}

local key_bindings = {
	awesome = {
		{ { M.keys.mod }, "s", lst.awesome.show_help, "show help" },
		{ { M.keys.mod }, "w", lst.awesome.show_menu, "show main menu" },
		{ { M.keys.mod, "Control" }, "r", lst.awesome.restart, "reload awesome" },
		{ { M.keys.mod, "Shift" }, "q", lst.awesome.quit, "quit awesome" },
		{ { M.keys.mod }, "x", lst.awesome.run_lua_code, "lua execute prompt" },
	},
	client = {
		{ { M.keys.mod }, "f", lst.client.tgl_fullscreen, "toggle fullscreen" },
		{ { M.keys.mod }, "q", lst.client.close, "close" },
		{ { M.keys.mod, "Control" }, "space", lst.client.tgl_floating, "toggle floating" },
		{ { M.keys.mod, "Control" }, "Return", lst.client.swap, "move to master" },
		{ { M.keys.mod }, "o", lst.client.mv_to_screen, "move to screen" },
		{ { M.keys.mod }, "t", lst.client.tgl_keep_on_top, "toggle keep on top" },
		{ { M.keys.mod }, "n", lst.client.minimize, "minimize" },
		{ { M.keys.mod, "Control" }, "n", lst.client.restore, "restore" },
		{ { M.keys.mod }, "m", lst.client.tgl_max, "(un)maximize" },
		{ { M.keys.mod, "Control" }, "m", lst.client.tgl_max_vt, "(un)maximize vertically" },
		{ { M.keys.mod, "Shift" }, "m", lst.client.tgl_max_hz, "(un)maximize horizontally" },
		{ { M.keys.mod }, "k", lst.client.focus_on_next, "focus next by index" },
		{ { M.keys.mod }, "j", lst.client.focus_on_prev, "focus previous by index" },
		{ { M.keys.mod, "Shift" }, "j", lst.client.swap_with_next, "swap with next client by index" },
		{ { M.keys.mod, "Shift" }, "k", lst.client.swap_with_prev, "swap with previous client by index" },
		{ { M.keys.mod }, "u", lst.client.jmp_to_urg, "jump to urgent client" },
		{ { M.keys.mod }, "Tab", lst.go_back, "go back" },
	},
	launcher = {
		{ { M.keys.mod }, "Return", lst.launcher.spawn_terminal, "open a terminal" },
		{ { M.keys.mod }, "r", lst.launcher.run_prompt, "run prompt" },
		{ { M.keys.mod }, "e", lst.launcher.launch_rofi, "open launcher" },
		{ { M.keys.mod }, "b", lst.launcher.launch_browser, "launch browser" },
		{ { M.keys.mod }, "p", lst.launcher.show_menubar, "show the menubar" },
	},
	layout = {
		{ { M.keys.mod }, "l", lst.layout.inc_width, "increase master width factor" },
		{ { M.keys.mod }, "h", lst.layout.dec_width, "decrease master width factor" },
		{ { M.keys.mod, "Shift" }, "h", lst.layout.inc_num_masters, "increase the number of master clients" },
		{ { M.keys.mod, "Shift" }, "l", lst.layout.dec_num_masters, "decrease the number of master clients" },
		{ { M.keys.mod, "Control" }, "h", lst.layout.inc_num_cols, "increase the number of columns" },
		{ { M.keys.mod, "Control" }, "l", lst.layout.dec_num_cols, "decrease the number of columns" },
		{ { M.keys.mod }, "space", lst.layout.select_next, "select next" },
		{ { M.keys.mod, "Shift" }, "space", lst.layout.select_prev, "select previous" },
	},
	screen = {
		{ { M.keys.mod, "Control" }, "k", lst.screen.focus_on_next, "focus the next screen" },
		{ { M.keys.mod, "Control" }, "j", lst.screen.focus_on_prev, "focus the previous screen" },
	},
	tag = {
		{ { M.keys.mod }, "Left", awful.tag.viewprev, "view previous" },
		{ { M.keys.mod }, "Right", awful.tag.viewnext, "view next" },
		{ { M.keys.mod }, "Escape", awful.tag.history.restore, "go back" },
	},
}

local function flatten(tbl)
	local flat = {}
	for _, sub_tbl in pairs(tbl) do
		gears.table.merge(flat, sub_tbl)
	end
	return flat
end

local function attach(binding, grp)
	return awful.key(binding[1], binding[2], binding[3], { description = binding[4], group = grp })
end

local function group(grp, bindings)
	return flatten(gears.table.map(function(bnd)
		return attach(bnd, grp)
	end, bindings))
end

function M.bind()
	local global_keys = {}
	for grp, bindings in pairs(key_bindings) do
		M.bindings[grp] = group(grp, bindings)
		gears.table.merge(global_keys, M.bindings[grp])
	end

	-- Bind all key numbers to tags.
	-- Be careful: we use keycodes to make it work on any keyboard layout.
	-- This should map on the top row of your keyboard, usually 1 to 9.
	for i = 1, 9 do
		global_keys = gears.table.join(
			global_keys,
			-- View tag only.
			awful.key({ M.keys.mod }, "#" .. i + 9, function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end, { description = "view tag #" .. i, group = "tag" }),
			-- Toggle tag display.
			awful.key({ M.keys.mod, "Control" }, "#" .. i + 9, function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end, { description = "toggle tag #" .. i, group = "tag" }),
			-- Move client to tag.
			awful.key({ M.keys.mod, "Shift" }, "#" .. i + 9, function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end, { description = "move focused client to tag #" .. i, group = "tag" }),
			-- Toggle tag on focused client.
			awful.key({ M.keys.mod, "Control", "Shift" }, "#" .. i + 9, function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end, { description = "toggle focused client on tag #" .. i, group = "tag" })
		)
	end

	-- Set keys
	root.keys(global_keys)
end

return M
