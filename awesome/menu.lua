local awful = require("awful")

-- local act = require("actions")
local apps = require("apps")

return awful.menu({
  items = {
    -- { "hotkeys", act.awesome.show_help },
    { "open terminal", apps.terminal },
  },
})
