local textbox = require("wibox.widget.textbox")
local timer = require("gears.timer")
local spawn = require("awful.spawn")

local ranges = {
  {
    min = 0,
    max = 5,
    icon = "󰂎", -- nf-md-battery_outline
  },
  {
    min = 5,
    max = 10,
    icon = "󰁺", -- nf-md-battery_10
  },
  {
    min = 10,
    max = 20,
    icon = "󰁻", -- nf-md-battery_20
  },
  {
    min = 20,
    max = 30,
    icon = "󰁼", -- nf-md-battery_30
  },
  {
    min = 30,
    max = 40,
    icon = "󰁽", -- nf-md-battery_40
  },
  {
    min = 40,
    max = 50,
    icon = "󰁾", -- nf-md-battery_50
  },
  {
    min = 50,
    max = 60,
    icon = "󰁿", -- nf-md-battery_60
  },
  {
    min = 60,
    max = 70,
    icon = "󰂀", -- nf-md-battery_70
  },
  {
    min = 70,
    max = 80,
    icon = "󰂁", -- nf-md-battery_80
  },
  {
    min = 80,
    max = 90,
    icon = "󰂂", -- nf-md-battery_90
  },
  {
    min = 90,
    max = 100,
    icon = "󰁹", -- nf-md-battery
  },
}

local cmd = "acpi"

local get_display = function(stdout, stderr)
  local message = string.len(stderr) > 0 and "error: " .. stderr or stdout
  local _, _, perc = string.find(message, "(%d+)%%")
  if perc then
    local level = tonumber(perc)
    local display = perc
    for _, rg in pairs(ranges) do
      if level > rg.min and level <= rg.max then
        display = rg.icon .. " " .. display
        break
      end
    end
    return display
  end
end

return function(timeout)
  local wd = textbox()
  local tm = timer({ timeout = timeout or 5 })
  tm:connect_signal("timeout", function()
    tm:stop()
    -- selene: allow(unused_variable)
    spawn.easy_async(cmd, function(stdout, stderr, exit_reason, exit_code) ---@diagnostic disable-line: unused-local
      wd:set_text(get_display(stdout, stderr))
    end)
    tm:again()
  end)
  tm:start()
  tm:emit_signal("timeout")
  return wd, tm
end
