local awful = require("awful")

local startup_apps = {
  "picom -b",
  "VBoxClient --clipboard",
}

local M = {}

local function run_once(cmd)
  local find_me = cmd
  local first_space = cmd:find(" ")
  if first_space then
    find_me = cmd:sub(0, first_space - 1)
  end
  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", find_me, cmd))
end

local function init()
  for _, app in ipairs(startup_apps) do
    run_once(app)
  end
end

return setmetatable(M, {
  __call = function()
    init()
  end,
})
