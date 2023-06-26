local awful = require("awful")

local M = {}

function M.tgl_fullscreen(client)
	client.fullscreen = not client.fullscreen
	client:raise()
end

function M.close()
  local client = awful.client.next(0)
	client:kill()
end

function M.tgl_floating()
	awful.client.floating.toggle()
end

function M.swap()
  local client = awful.client.next(0)
	client:swap(awful.client.getmaster())
end

function M.mv_to_screen()
  local client = awful.client.next(0)
	client:move_to_screen()
end

function M.tgl_keep_on_top()
  local client = awful.client.next(0)
	client.ontop = not client.ontop
end

function M.minimize()
  local client = awful.client.next(0)
	client.minimized = true
end

function M.restore()
	local client = awful.client.restore()
	if client then
		client:emit_signal("request::activate", "key.unminimize", { raise = true })
	end
end

function M.tgl_max()
  local client = awful.client.next(0)
	client.maximized = not client.maximized
	client:raise()
end

function M.tgl_max_vt()
  local client = awful.client.next(0)
	client.maximized_vertical = not client.maximized_vertical
	client:raise()
end

function M.tgl_max_hz()
  local client = awful.client.next(0)
	client.maximized_horizontal = not client.maximized_horizontal
	client:raise()
end

function M.focus_on_next()
	awful.client.focus.byidx(1)
end

function M.focus_on_prev()
	awful.client.focus.byidx(-1)
end

function M.swap_with_next()
	awful.client.swap.byidx(1)
end

function M.swap_with_prev()
	awful.client.swap.byidx(-1)
end

function M.jmp_to_urg()
	awful.client.urgent.jumpto()
end

function M.go_back()
	awful.client.focus.history.previous()
	if awful.client.focus then
		awful.client.focus:raise()
	end
end

return M
