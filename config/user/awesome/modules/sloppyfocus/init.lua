-- Enable sloppy focus, so that focus follows mouse.
local beautiful = require("beautiful")
local client = require("client")

local M = {}

local function init()
	client.connect_signal("mouse::enter", function(c)
		c:emit_signal("request::activate", "mouse_enter", { raise = false })
	end)

	client.connect_signal("focus", function(c)
		c.border_color = beautiful.border_focus
	end)
	client.connect_signal("unfocus", function(c)
		c.border_color = beautiful.border_normal
	end)
end

return setmetatable(M, {
    __call = function()
      init()
    end
  }
)
