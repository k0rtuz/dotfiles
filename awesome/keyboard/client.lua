local gears = require("gears")

local act = require("actions")
local key = require("awful.key")
local kb = require("keyboard.base")

return {
  global = gears.table.join(
    key({ kb.mod }, "k", act.client.focus_on_next, { description = "Focus next by index", group = "client" }),
    key({ kb.mod }, "j", act.client.focus_on_prev, { description = "Focus previous by index", group = "client" }),
    key(
      { kb.mod, kb.sh },
      "k",
      act.client.swp_next,
      { description = "Swap with next client by index", group = "client" }
    ),
    key(
      { kb.mod, kb.sh },
      "j",
      act.client.swp_prev,
      { description = "Swap with previous client by index", group = "client" }
    ),
    key({ kb.mod }, "Tab", act.client.go_back, { description = "Go back", group = "client" }),
    key({ kb.mod, kb.ctrl }, "n", act.client.restore, { description = "Restore", group = "client" }),
    key({ kb.mod }, "u", act.client.jmp_to_urg, { description = "Jump to urgent client", group = "client" })
  ),
  instance = gears.table.join(
    key({ kb.mod }, "f", act.client.tgl_full, { description = "Toggle fullscreen", group = "client" }),
    key({ kb.mod }, "q", act.client.close, { description = "Close", group = "client" }),
    key({ kb.mod, kb.ctrl }, kb.sp, act.client.tgl_flt, { description = "Toggle floating", group = "client" }),
    key({ kb.mod, kb.ctrl }, kb.ret, act.client.swap, { description = "Move to master", group = "client" }),
    key({ kb.mod }, "o", act.client.mv_to_scr, { description = "Move to screen", group = "client" }),
    key({ kb.mod }, "t", act.client.keep_on_top, { description = "Toggle keep on top", group = "client" }),
    key({ kb.mod }, "n", act.client.minimize, { description = "Minimize", group = "client" }),
    key({ kb.mod }, "m", act.client.tgl_max, { description = "(Un)maximize", group = "client" }),
    key({ kb.mod, kb.ctrl }, "m", act.client.tgl_max_vt, { description = "(Un)maximize vertically", group = "client" }),
    key({ kb.mod, kb.sh }, "m", act.client.tgl_max_hz, { description = "(Un)maximize horizontally", group = "client" })
  ),
}
