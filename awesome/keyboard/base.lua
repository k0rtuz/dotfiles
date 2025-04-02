local awful = require("awful")
local CircularLinkedList = require("aux.cll")

---@diagnostic disable: need-check-nil
local cycler = function(available_layouts)
  local layouts = CircularLinkedList:new()
  for _, lay in pairs(available_layouts) do
    layouts:append(lay)
  end
  local current_layout = layouts:head()

  return function()
    current_layout = current_layout.next
    awful.spawn(string.format("setxkbmap %s", current_layout.value))
  end
end

return {
  mod = "Mod4",
  alt = "Mod1",
  ctrl = "Control",
  sh = "Shift",
  sp = "space",
  ret = "Return",
  tab = "Tab",
  left = "Left",
  right = "Right",
  esc = "Escape",
  cycle = cycler({ "us", "es" }),
}
